# Telemetry — core_domain

> **Purpose:** Domain contracts and pure logic for the telemetry upload pipeline.
> Implementation lives in `core_runtime/lib/telemetry/`.

---

## Overview

The telemetry subsystem collects `WindowResult` analytics from the detection engine,
serialises them, and delivers them to the configured backend endpoint.
This package defines the **what**, not the **how**:

- **Models** — immutable wire types and queue metadata.
- **Service contracts** — abstract interfaces with Riverpod stubs.
- **UploadWorker** — the only piece of business logic (pure Dart, no I/O).

```
WindowResult
    │
    ▼  (WindowResultMapper — core_runtime)
TelemetryPayload
    │
    ▼  (PayloadQueueRepository — Drift in core_runtime)
Persistent queue
    │
    ▼  (UploadWorker.run())
PayloadSerializer ──► bytes ──► TelemetryTransport ──► Backend
```

---

## Files

| File                                     | Purpose                                                        |
| ---------------------------------------- | -------------------------------------------------------------- |
| `models/telemetry_payload.dart`          | Freezed wire model for one observation window                  |
| `models/area_payload.dart`               | Embedded per-area analytics (part of `telemetry_payload.dart`) |
| `models/queued_payload.dart`             | Queue row: payload + retry / upload / discard metadata         |
| `models/upload_session.dart`           | Runtime-resolved DataServer + auth + upload config             |
| `state/models/upload_config.dart`      | Persisted upload timing, retry, batching, retention settings   |
| `services/payload_queue_repository.dart` | Abstract persistent queue (enqueue / fetchReady / mark*)       |
| `services/payload_serializer.dart`       | Abstract serialiser (JSON today, Protobuf later)               |
| `services/telemetry_transport.dart`      | Abstract transport (HTTP today, gRPC later)                    |
| `services/telemetry_service.dart`        | Top-level facade (enqueue / flush / startPeriodicUpload)       |
| `delivery_response_worker.dart`          | Parses raw backend response into ok / error / clientError      |
| `upload_worker.dart`                     | Upload loop: batch drain, retry, back-off, discard, status     |

---

## UploadWorker behaviour

1. Calls `sessionResolver()` — returns `null` when no backend is configured
   (first-run or `Backend.unspecified()`); run is a **no-op** and status
   attributes are not updated.
2. Prunes expired items (`createdAt < now - payloadRetentionDays`).
3. Fetches up to `batchSize` ready items from the queue.
4. Serialises the batch and POSTs it via `TelemetryTransport`.
5. On success: marks items uploaded (`markUploadedBatch`) and updates
    `isLastUploadSuccess = true`, clears error fields.
6. On server rejection or transport exception: stops the current run,
     sets `isLastUploadSuccess = false`, and populates
    `lastError` / `lastErrorDetail` / `lastClientError`.

## Worker status attributes

After each `run()`, the worker exposes the outcome via mutable fields:

| Field                 | Type        | Meaning                                                  |
| --------------------- | ----------- | -------------------------------------------------------- |
| `lastUploadTimeUtc`   | `DateTime?` | When the most recent attempt (success or failure) ran    |
| `isLastUploadSuccess` | `bool?`     | `true` = success, `false` = failure, `null` = never ran  |
| `lastError`           | `String?`   | Machine-readable error code (e.g. `transport_exception`) |
| `lastErrorDetail`     | `String?`   | Human-readable error detail                              |
| `lastClientError`     | `bool?`     | `true` = 4xx client error, `false` = network/server      |
All fields remain `null` until the first upload attempt completes.

---

## Retry & scheduling

| Setting         | Default    | Meaning                           |
| --------------- | ---------- | --------------------------------- |
| `batchSize`     | 10         | Max payloads per HTTP request     |
| `maxRetryCount` | 20         | Attempts before permanent discard |
| `maxAgeHours`   | 24         | Age at which items are pruned     |
| Upload cadence  | Every hour | Wall-clock aligned (1:00, 2:00 …) |

Retry scheduling (`nextRetryTimeUtc`) is owned by `TelemetryService`
implementations (for example `NativeTelemetryService`), not by
`UploadWorker`.

---

## Testing

See `test/telemetry/delivery_worker_test.dart` for unit tests that cover:
- No-op when no backend is configured
- Expiry pruning with correct cutoff
- Successful single and multi-batch drain
- Retry scheduling after server rejection
- Retry scheduling after transport exception
- Discard after max retries exceeded
- Stop-after-first-failure behaviour
- **Status attributes** — initial null state, success path, server-rejection
  path, transport-exception path, all-discarded path, multi-batch update

All collaborators are replaced with lightweight stub implementations —
no code generation or I/O required.
