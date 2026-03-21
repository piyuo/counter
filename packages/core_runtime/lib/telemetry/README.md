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
       └── DeliveryWorker         (pure domain logic, from core_domain)
```

---

## Files

| File                                  | Purpose                                                  |
| ------------------------------------- | -------------------------------------------------------- |
| `telemetry_database.dart`             | Drift `@DriftDatabase` with `PendingPayloads` table      |
| `drift_payload_queue_repository.dart` | SQLite-backed `PayloadQueueRepository`                   |
| `json_payload_serializer.dart`        | Serialises payload batches as a UTF-8 JSON array         |
| `http_telemetry_transport.dart`       | HTTP POST transport with Bearer auth                     |
| `window_result_mapper.dart`           | Maps `vision.WindowResult` → `TelemetryPayload`          |
| `native_telemetry_service.dart`       | Top-level facade; manages the config-driven upload timer |

---

## Database schema

Table: **`pending_payloads`** (schema version 2)

- `id` (TEXT PK): Matches `TelemetryPayload.payloadId` (UUID v4)
- `payload_json` (TEXT): Full JSON from `TelemetryPayload.toJson()`
- `retry_count` (INTEGER): Defaults to 0
- `next_retry_at_ms` (INTEGER): UTC ms-since-epoch; set to `now` on enqueue
- `created_at_ms` (INTEGER): UTC ms-since-epoch; used for expiry pruning
- `start_ms` (INTEGER): UTC ms-since-epoch; copied from `TelemetryPayload.startUtc`
- `end_ms` (INTEGER): UTC ms-since-epoch; copied from `TelemetryPayload.endUtc`
- `delivered_at_ms` (INTEGER): Nullable; set on success, retained for 7 days

Behavior notes:

- Successful deliveries are **not deleted immediately**. They are marked with
  `delivered_at_ms` and excluded from pending delivery queries.
- UI/debug screens can call `fetchRecent(daysBack)` to retrieve all retained
  payloads in one list. Delivered rows can be identified by a non-null
  `PendingPayload.deliveredAt`.
- `pruneExpired(before)` applies one retention rule to all rows based on
  `created_at_ms`, regardless of delivery status.
- Queue rows persist both observation bounds (`start_ms`, `end_ms`) so
  engineers can audit by explicit window semantics.
- Event-time ordering uses `end_ms` (window end), not enqueue or delivery time.

---

## Upload schedule

`NativeTelemetryService.startPeriodicUpload()` resolves the active cadence,
computes the **next aligned wall-clock upload slot**, and schedules a single
one-shot timer. After each upload attempt, it repeats the same calculation and
schedules the next one-shot timer.

This keeps uploads aligned to the latest `UploadConfig.wallClockCadenceMin`
setting without minute polling or cadence-boundary checks on every minute tick.

Call `flush()` on app start and on lifecycle pause/terminate to drain the queue
immediately without waiting for the next hour boundary.

---

## WindowResultMapper

Converts a `vision.WindowCountState` (from the detection engine) to the
`TelemetryPayload` wire model.

- Generates a fresh **UUID v4** `payloadId` per result for server-side
  idempotent de-duplication on retry.
- Requires a `deviceId` string (injected at construction time).

---

## HTTP transport

- Method: `POST`
- Headers: `Authorization: Bearer <token>`, `Content-Type: <contentType>`
- Throws `Exception` on any non-2xx status so `DeliveryWorker` applies retry
  logic.

---

## Testing

See `test/telemetry/` for unit tests covering:

- `json_payload_serializer_test.dart`: Encoding correctness, content-type.
- `http_telemetry_transport_test.dart`: POST headers/body, 2xx success, non-2xx throws.
- `drift_payload_queue_repository_test.dart`: Queue lifecycle including success retention and reset APIs.
- `window_result_mapper_test.dart`: Field mapping, unique IDs, and deviceId propagation.
- `native_telemetry_service_test.dart`: Enqueue delegation, flush no-op, and timer lifecycle.
