# core_domain

Pure-Dart domain layer for the Counter app.  No platform dependencies — only
models, abstract service contracts, and business logic.

## What's in here

| Sub-directory       | Purpose                                                              |
| ------------------- | -------------------------------------------------------------------- |
| `state/models/`     | App-wide value types (`DeliveryConfig`, `DataServer`, …)             |
| `telemetry/`        | Delivery pipeline: queue models, service contracts, `DeliveryWorker` |
| `app_flow/`         | App lifecycle domain types                                           |
| `navigation/`       | Navigation route models                                              |
| `services/`         | Shared abstract service interfaces                                   |
| `system_lifecycle/` | System-level lifecycle hooks                                         |

Implementation of the abstract interfaces lives in `packages/core_runtime`.

## Telemetry subsystem

The telemetry pipeline collects observation-window analytics, persists them in
a local SQLite queue, and delivers them to the configured backend endpoint.

```
WindowResult
    │
    ▼  (WindowResultMapper — core_runtime)
TelemetryPayload
    │
    ▼  (TelemetryQueueRepository — Drift in core_runtime)
Persistent queue
    │
    ▼  (DeliveryWorker.run())
PayloadSerializer ──► bytes ──► TelemetryTransport ──► Backend
```

See [`lib/telemetry/README.md`](lib/telemetry/README.md) for a detailed
description of the delivery loop, retry/discard logic, and worker status
attributes.

## Testing

```bash
flutter test
```

All tests use lightweight in-memory stubs — no code generation, Drift, or
network I/O required.
