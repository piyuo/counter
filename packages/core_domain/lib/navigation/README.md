# Navigation — Hybrid Routing System

Two complementary routing mechanisms, each handling what it is suited for:

| Mechanism         | Handles                                      | Implementation                                                      |
| ----------------- | -------------------------------------------- | ------------------------------------------------------------------- |
| **State routing** | Safety constraints, persistent gates         | `RouteDecisionEngine` + `RouteRule` plugins via GoRouter `redirect` |
| **Event routing** | One-shot actions (open settings, open about) | `navigationEventBusProvider` stream → `router.go()` directly        |

---

## File Structure

```  dart
navigation/
├── README.md                       ← this file
├── navigation_event_bus.dart       ControlPanelNavigationEvent + stream provider
├── control_panel_routes.dart       path constants (no logic)
├── route_context.dart              unified input snapshot (pure value object)
├── route_decision.dart             decision value object (target, reason)
├── route_rule.dart                 abstract plugin contract
├── route_decision_engine.dart      executes rules in priority order
└── rules/
    ├── system_lifecycle_rule.dart  priority  0 — hardware/lifecycle
    └── app_flow_rule.dart          priority 10 — onboarding gates
```

---

## State Routing — `RouteDecisionEngine`

Used for **persistent truths** that must always be enforced.
Runs inside GoRouter's `redirect` callback on every navigation.

### 1. `RouteContext` — pure value input

```dart
final ctx = RouteContext(
  lifecycle:   ...,  // SystemLifecycle state-machine value
  flow:        ...,  // AppFlow state-machine value
  currentPath: ...,  // currently active GoRouter path
);
```

### 2. `RouteRule` — plugin contract

```dart
abstract class RouteRule {
  int get priority;                           // lower = runs first
  RouteDecision? evaluate(RouteContext ctx);  // null = no opinion
}
```

### 3. `RouteDecision` — result value object

```dart
RouteDecision(
  target: '/onboarding',                // path to navigate to
  reason: 'app-flow: onboarding gate',  // optional — for logging / analytics
)
```

### 4. `RouteDecisionEngine` — pipeline executor

```dart
final engine = RouteDecisionEngine(rules); // sorts by priority on construction
final decision = engine.decide(context);   // first non-null, non-current-path wins
// router uses: decision?.target
```

#### Loop detection

`decide()` simulates the full redirect chain before returning. If any path repeats
(e.g. `/a → /b → /a`) the engine returns `null` instead of letting GoRouter enter
an infinite redirect loop. A hard cap of 20 hops acts as a backstop against
pathological rule combinations.

#### Debug logging

Every call to `decide()` logs each rule's verdict via `appkit.logInfo` (the same
logging system used by `AppFlowNotifier`). Output is controlled by appkit's log
configuration — no separate flag needed.

Sample output:

``` dart
[RouteDecisionEngine] decide() at "/"
[RouteDecisionEngine]   SystemLifecycleRule(p:0)  → no opinion
[RouteDecisionEngine]   AppFlowRule(p:10)         → "/onboarding" [app-flow: onboarding gate]
```

Cycle output:

``` dart
[RouteDecisionEngine] cycle detected: /a → /b → /a — returning null
```

---

## Priority Ranges

| Range   | Intended use                                      |
| ------- | ------------------------------------------------- |
| `0–9`   | System lifecycle — hardware errors, degraded boot |
| `10–99` | App flow gates — onboarding, auth, subscriptions  |

---

## Existing Rules

### `SystemLifecycleRule` (priority 0)

Redirects to `/live-stream-only` when the hardware check finds no camera.
Runs before everything else — a degraded system overrides all other concerns.

### `AppFlowRule` (priority 10)

Redirects to `/onboarding` for both `onboardingRequired` and `onboardingByInvitation`
flow states. Acts as a gate: the user cannot bypass onboarding.

---

## Plugin Registry

Rules are assembled in `feature_control_panel/lib/router/route_rules_provider.dart`:

```dart
final routeRulesProvider = Provider<List<RouteRule>>((ref) {
  return const [
    SystemLifecycleRule(),   // 0
    AppFlowRule(),           // 10

    // Add new rules here — engine sorts by priority automatically:
    // AuthenticationRule()     // e.g. priority 5
    // SubscriptionGateRule()   // e.g. priority 20
    // HardwareErrorRule()      // e.g. priority 1
  ];
});
```

---

## Adding a New State Rule

1. Create a file in `rules/` (or inside the owning feature package):

```dart
class HardwareErrorRule implements RouteRule {
  const HardwareErrorRule();

  @override
  int get priority => 1;

  @override
  RouteDecision? evaluate(RouteContext context) {
    final target = context.lifecycle.whenOrNull(
      systemError: (_) => ControlPanelRoutes.error,
    );
    if (target == null) return null;
    return RouteDecision(target: target, reason: 'system-lifecycle: hardware error');
  }
}
```

1. Register it in `routeRulesProvider`. No other file needs to change.

---

## Event Routing — `navigationEventBusProvider`

Used for **one-shot actions** that are not persistent state.
The router subscribes to the stream and calls `router.go()` directly —
no `consume()`, no clearing, no stale state.

### Emit from UI

```dart
// open settings button
ref.read(navigationEventBusProvider).add(const OpenSettings());

// open about button
ref.read(navigationEventBusProvider).add(const OpenAbout());
```

### How the router reacts

In `feature_control_panel/lib/router/router_provider.dart` the router
subscribes once at construction:

```dart
ref.read(navigationEventBusProvider).stream.listen((event) {
  switch (event) {
    case OpenSettings(): router.go(ControlPanelRoutes.settings);
    case OpenAbout():    router.go(ControlPanelRoutes.about);
  }
});
```

### Adding a new navigation event

1. Add a class in `navigation_event_bus.dart`:

```dart
class OpenHelp extends ControlPanelNavigationEvent {
  const OpenHelp();
}
```

1. Add a `case` in the router's stream listener.

---

## Testing

`RouteContext` is a pure Dart value object — no Riverpod container needed:

```dart
test('redirects to live-stream-only when camera missing', () {
  final ctx = RouteContext(
    lifecycle: const SystemLifecycle.liveStreamOnly(),
    flow: const AppFlow.sessionRunning(),
    currentPath: '/',
  );

  final decision = SystemLifecycleRule().evaluate(ctx);
  expect(decision?.target, ControlPanelRoutes.liveStreamOnly);
});

test('engine returns null when no rule fires', () {
  final engine = RouteDecisionEngine([SystemLifecycleRule(), AppFlowRule()]);
  final ctx = RouteContext(
    lifecycle: const SystemLifecycle.systemReady(),
    flow: const AppFlow.sessionRunning(),
    currentPath: '/',
  );

  expect(engine.decide(ctx), isNull);
});
```
