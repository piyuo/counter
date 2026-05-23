# Telemetry — core_runtime

> **Purpose:** Platform implementations of the telemetry contracts defined in `core_domain/lib/telemetry/`.

---

## Overview

This package provides the concrete classes wired up in `main.dart` via Riverpod
provider overrides.

```text
NativeTelemetryService
 ├── DriftPayloadQueueRepository  (SQLite via Drift)
 ├── JsonPayloadSerializer        (UTF-8 JSON)
 └── HttpTelemetryTransport       (HTTP POST)
       └── UploadWorker           (pure domain logic, from core_domain)
```

---

## Files

| File                                  | Purpose                                                                   |
| ------------------------------------- | ------------------------------------------------------------------------- |
| `telemetry_database.dart`             | Drift `@DriftDatabase` with queue and upload-log tables plus SQLite setup |
| `drift_payload_queue_repository.dart` | SQLite-backed `TelemetryQueueRepository`                                  |
| `json_payload_serializer.dart`        | Serialises payload batches as a UTF-8 JSON array                          |
| `http_telemetry_transport.dart`       | HTTP POST transport with Bearer auth                                      |
| `window_result_mapper.dart`           | Maps `vision.WindowCountState` to `TelemetryPayload`                      |
| `native_telemetry_service.dart`       | Top-level facade; schedules aligned uploads and exposes status            |

---

## Database schema

The runtime database is `TelemetryDatabase` (schema version 1) with two tables.

Table: **`telemetry_queue`**

- `id` (TEXT PK): Matches `TelemetryPayload.id` (UUID v4).
- `serialized_payload` (TEXT): Full JSON from `TelemetryPayload.toJson()`.
- `created_at_ms` (INTEGER): UTC ms-since-epoch when the payload was enqueued.
- `start_ms` (INTEGER): UTC ms-since-epoch copied from `TelemetryPayload.startUtc`.
- `end_ms` (INTEGER): UTC ms-since-epoch copied from `TelemetryPayload.endUtc`.
- `delivered_at_ms` (INTEGER, nullable): Set when a payload upload succeeds.

Table: **`telemetry_upload_log`**

- `id` (INTEGER PK): Semantic hour/status key in `yyyyMMddHHs` form.
- `success` (BOOLEAN): Whether the upload attempt succeeded.
- `attempted_at_ms` (INTEGER): UTC ms-since-epoch when the attempt ran.
- `size_kb` (INTEGER): Serialized upload size in KB.
- `payload_count` (INTEGER): Number of payloads included in the attempt.
- `retry_count` (INTEGER): Retry number captured for that attempt.
- `error` (TEXT, nullable): Human-readable failure message.

Behavior notes:

- Successful deliveries are retained and marked by `delivered_at_ms`; pending
  scans only include rows where that column is null.
- `fetchReady()` reads pending rows oldest-first so retries do not starve older
  payloads.
- `fetchRecent(daysBack)` returns both pending and uploaded payloads based on
  `created_at_ms` only.
- `pruneExpired(before)` applies one retention rule to queue rows based on
  `created_at_ms`, regardless of upload status.
- `pruneUploadLogs(before)` trims upload-attempt history separately.
- Queue rows persist `start_ms` and `end_ms` so engineers can audit by event
  window rather than enqueue time.

### SQLite pragmas

`TelemetryDatabase.open()` configures SQLite for a small, steady-state telemetry
workload:

- `PRAGMA journal_mode=WAL;`
- `PRAGMA busy_timeout=5000;`
- `PRAGMA synchronous=NORMAL;`
- `PRAGMA foreign_keys=ON;`
- `PRAGMA wal_autocheckpoint=5000;`
- `PRAGMA journal_size_limit=52428800;`

The queue is expected to grow to a stable size and reuse freed pages, so routine
`VACUUM` is not part of normal operation.

---

## Upload schedule

`NativeTelemetryService.startPeriodicUpload()` resolves the active cadence,
computes the next aligned wall-clock upload slot, applies stable per-device
jitter, and schedules a single one-shot timer. After each scheduled attempt, it
recomputes from the latest config and schedules the next timer again.

This keeps uploads aligned to `UploadConfig.wallClockCadenceMin` without minute
polling. Manual uploads should use `uploadNow()` when the app starts, pauses, or
otherwise needs to drain the queue immediately.

---

## WindowResultMapper

Converts a `vision.WindowCountState` (from the detection engine) to the
`TelemetryPayload` wire model.

- Generates a fresh UUID v4 `payloadId` per result for server-side idempotent
  de-duplication on retry.
- Requires a `deviceId` string injected at construction time.

---

## HTTP transport

- Method: `POST`
- Headers: `Authorization: Bearer <token>`, `Content-Type: <contentType>`
- Throws `Exception` on any non-2xx status so `UploadWorker` can apply retry
  logic.

---

## Testing

See `test/telemetry/` for unit tests covering:

- `telemetry_database_test.dart`: SQLite pragmas, file creation, and corruption recovery.
- `drift_payload_queue_repository_test.dart`: Queue lifecycle, retention, and upload logs.
- `json_payload_serializer_test.dart`: Encoding correctness and content type.
- `http_telemetry_transport_test.dart`: POST headers/body, 2xx success, and non-2xx throws.
- `window_result_mapper_test.dart`: Field mapping, unique IDs, and deviceId propagation.
- `native_telemetry_service_test.dart`: Enqueue delegation, `uploadNow()`, and timer lifecycle.
- `native_telemetry_service_integration_test.dart`: End-to-end scheduling and queue draining.
