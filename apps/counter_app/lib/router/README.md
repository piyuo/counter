# Router — Control Panel Routing Layer

Wires GoRouter with the two routing mechanisms defined in `core_domain/navigation`.

---

## File Structure

```
router/
├── README.md                   ← this file
├── router_provider.dart        GoRouter instance — state-driven + event-driven routing
├── route_rules_provider.dart   Plugin registry — which RouteRule plugins are active
└── control_panel_route_map.dart  All GoRoute entries (path → screen)
```

---

## How the Two Routing Mechanisms Work

### State-driven routing (persistent gates)

`systemLifecycleProvider` and `appFlowProvider` changes increment a `ValueNotifier`
→ GoRouter calls its `redirect` callback
→ `RouteDecisionEngine.decide(RouteContext)` runs all registered rules in priority order
→ first non-null result wins; `null` means "stay here"

### Event-driven routing (one-shot actions)

UI widgets emit a `ControlPanelNavigationEvent` onto `navigationEventBusProvider`
→ router's stream listener calls `router.go()` directly
→ bypasses the redirect cycle — no consume(), no stale state

---

## Adding a New Route

1. Add a path constant in `core_domain/lib/navigation/control_panel_routes.dart`.
2. Add a `GoRoute` entry in `control_panel_route_map.dart`.
3. If it needs a redirect guard, add a `RouteRule` (see below).

## Adding a New Routing Rule (persistent gate)

1. Implement `RouteRule` in the relevant package:

```dart
class AuthenticationRule implements RouteRule {
  const AuthenticationRule();

  @override
  int get priority => 5;

  @override
  RouteDecision? evaluate(RouteContext context) {
    // return RouteDecision(target: '/path', reason: '...'), or null to pass through
  }
}
```

2. Register it in `route_rules_provider.dart` — no other file needs to change.

## Adding a New Navigation Event (one-shot)

1. Add a class in `core_domain/lib/navigation/navigation_event_bus.dart`:

```dart
class OpenHelp extends ControlPanelNavigationEvent {
  const OpenHelp();
}
```

2. Add a `case` in the stream listener inside `router_provider.dart`:

```dart
case core_domain.OpenHelp():
  router.go(core_domain.ControlPanelRoutes.help);
```

---

## Priority Ranges (inherited from `core_domain`)

| Range   | Intended use                                      |
| ------- | ------------------------------------------------- |
| `0–9`   | System lifecycle — hardware errors, degraded boot |
| `10–99` | App flow gates — onboarding, auth, subscriptions  |
