# Agent Instructions

## Project

Piyuo Counter is a Flutter app for privacy-preserving pedestrian and vehicle counting. The repository is a Dart Pub workspace managed with Melos; `apps/counter_app` is the runnable app, with business rules and platform implementations split into packages.

Read [README.md](README.md) for product and platform setup, and [CONTRIBUTING.md](CONTRIBUTING.md) for the issue, branch, test, commit, and PR workflow.

## Commands

Run from the repository root unless noted:

```sh
melos bootstrap       # resolve dependencies for all workspace packages
melos run analyze     # analyze workspace packages
melos run test        # run the configured package test suite
melos run build       # run build_runner generators; does not compile the app
dart format <paths>   # format changed Dart files
```

`melos run build` can update generated sources and is slower than analysis or tests. Review generated diffs with the source changes. To run one test, use `cd <package> && flutter test test/<path>_test.dart`.

## Architecture

- `apps/counter_app/lib/`: app UI, startup wiring, and platform-facing providers; add screens here.
- `apps/counter_app/lib/router/`: `go_router` route definitions and generated route data; see its [README](apps/counter_app/lib/router/README.md).
- `packages/core_domain/lib/`: domain state, rules, and service contracts; keep platform implementations out.
- `packages/core_runtime/lib/`: implementations, persistence, and integrations for domain contracts.
- `packages/feature_*` and `packages/shared_l10n/`: feature packages and shared localization.
- `third_party/firebase_core/`: vendored fork with Windows plugin support removed; see its README before changing it.
- `scripts/` and `melos.yaml`: repository automation and workspace commands.

## Conventions

- Keep dependencies flowing from app/runtime implementations toward `core_domain` contracts; `apps/counter_app/lib/main.dart` is the composition root that binds them with Riverpod overrides.
- Add generated-code annotations to source files, then use `melos run build`; do not hand-edit `*.g.dart`, `*.freezed.dart`, or other generated outputs.
- Route definitions and generated route data belong in `apps/counter_app/lib/router/`; follow the local router README before changing route structure.
- The app package lists `.env` as a bundled asset. Never put secrets in it: app assets are extractable. Keep credentials local and out of commits.
- The app depends on `../flutter-vision`, outside this checkout. Do not replace that path dependency or vendor a second copy without approval.

## Tests

Tests live beside each package under its `test/` directory. Add or update focused tests for behavior changes; cover integration boundaries when changing persistence, routing, or platform services. Run `melos run analyze` and `melos run test` before handing off changes. There is no separate e2e test command configured in this repository.

## Boundaries

- **Always:** preserve existing user changes; regenerate rather than hand-edit generated files; keep secrets and signing credentials out of source control.
- **Ask first:** add or upgrade dependencies, change workspace/package boundaries, alter database schemas or migrations, modify native signing/release configuration, or change the vendored Firebase fork.
- **Never:** commit `.env` or credentials, hand-edit `pubspec.lock`, or disable analyzer rules just to make checks pass.

## Gotchas

- The root `melos.yaml` `build` script is code generation, not an app build. Platform builds are target-specific; follow the platform setup in [README.md](README.md).
- If `build_runner` reports a stale asset-graph `AssetNotFoundException` in `core_runtime`, clean that package's build_runner state and rerun generation there before retrying the workspace build.
- Flutter dependencies come from Pub, not npm; the root `pubspec.yaml` sets the Dart SDK floor to 3.11.

## Workflow

Follow [CONTRIBUTING.md](CONTRIBUTING.md) for issue-to-branch-to-PR steps. Use `scripts/start_issue.sh` to start issue branches and include the issue number in commit messages using the documented format.