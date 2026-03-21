# state/models

Immutable domain model objects that describe the app's persisted and runtime state.
All models use [freezed](https://pub.dev/packages/freezed) for value equality, `copyWith`, and (where applicable) JSON serialisation.

---

## Models at a glance

| File                     | Class             | Kind         | Persisted   | Purpose                                                         |
| ------------------------ | ----------------- | ------------ | ----------- | --------------------------------------------------------------- |
| `app_state.dart`         | `AppState`        | record       | JSON        | Top-level persisted snapshot of all user configuration          |
| `app_runtime_state.dart` | `AppRuntimeState` | record       | memory only | Transient session flags (e.g. developer mode)                   |
| `data_server.dart`       | `DataServer`      | sealed union | JSON        | Where telemetry is sent                                         |
| `video_source.dart`      | `VideoSource`     | sealed union | JSON        | Vision source (camera, file, URL…)                              |
| `setup_by.dart`          | `SetupBy`         | sealed union | JSON        | How the app was first configured                                |
| `detection.dart`         | `Detection`       | sealed union | JSON        | What kind of object to detect (human / vehicle)                 |
| `detection_params.dart`  | `DetectionParams` | record       | JSON        | Tracking/detection tuning parameters                            |
| `upload_params.dart`     | `UploadParams`    | record       | JSON        | Upload pipeline tuning (interval, retry, queue, batch, timeout) |
| `invitation.dart`        | `Invitation`      | record       | transient   | Server payload after redeeming an invitation code               |
| `upload_result.dart`     | `UploadResult`    | record       | transient   | Server response after a telemetry upload                        |

---

## Model details

### `AppState`

Persisted composite that captures all user configuration. Stored in `shared_preferences` via `AppStateRepository`.

| Field                      | Type                  | Default                     | Description                                   |
| -------------------------- | --------------------- | --------------------------- | --------------------------------------------- |
| `dataServer`               | `DataServer`          | derived getter              | Backward-compatible view of active selection  |
| `dataServerSelection`      | `DataServerSelection` | `unspecified`               | Which remembered data-server choice is active |
| `businessDataServer`       | `BusinessDataServer?` | `null`                      | Remembered invitation/business server         |
| `customPersonalDataServer` | `PersonalDataServer?` | `null`                      | Remembered custom personal server             |
| `piyuoPersonalDataServer`  | `PersonalDataServer?` | `null`                      | Remembered Piyuo Cloud personal server        |
| `videoSource`              | `VideoSource`         | `VideoSource.unspecified()` | Vision source                                 |
| `detection`                | `Detection`           | `Detection.human()`         | What kind of object to detect                 |
| `detectionParams`          | `DetectionParams`     | defaults                    | Tracking/detection tuning                     |
| `deliveryConfig`           | `DeliveryConfig`      | defaults                    | Upload pipeline tuning                        |
| `deviceId`                 | `String`              | `''`                        | Auto-generated unique device identifier       |

---

### `AppRuntimeState`

In-memory only — never written to disk. Holds transient flags that are reset on every cold start.

| Field                 | Type      | Default | Description                                              |
| --------------------- | --------- | ------- | -------------------------------------------------------- |
| `developMode`         | `bool`    | `false` | Unlocked by tapping App Version 10× in About             |
| `businessBearerToken` | `String?` | `null`  | Business auth token hydrated from secure storage at boot |

---

### `DataServer`  *(sealed union)*

Describes where the app sends its telemetry data. Business auth tokens are not
stored here; they live in secure storage and are mirrored into `AppRuntimeState`
for the current session.

| Variant                    | Key fields                                      | Meaning                            |
| -------------------------- | ----------------------------------------------- | ---------------------------------- |
| `DataServer.unspecified()` | —                                               | Default before onboarding          |
| `DataServer.business(…)`   | `url`, `projectName`, `projectId`, `assignedId` | Managed business endpoint metadata |
| `DataServer.personal(…)`   | `url`                                           | Personal endpoint                  |
| `DataServer.none()`        | —                                               | Explicitly opted out               |

Helper: `hasMadeDecision` → `true` when not `unspecified`.

---

### `VideoSource`  *(sealed union)*

Describes the vision source the counter reads from.

Helper: `hasMadeDecision` → `true` when not `unspecified`.

---

### `SetupBy`  *(sealed union)*

Records how the app was initially configured during onboarding.

| Variant                 | Meaning                             |
| ----------------------- | ----------------------------------- |
| `SetupBy.unspecified()` | Default before first setup          |
| `SetupBy.invitation()`  | Configured via invitation code      |
| `SetupBy.manual()`      | Configured by entering a server URL |
| `SetupBy.demo()`        | Configured in demo / trial mode     |

Helper: `hasBeenSetUp` → `true` when not `unspecified`.

---

### `Detection`  *(sealed union)*

Records what kind of object the vision engine should track.

| Variant               | Meaning             |
| --------------------- | ------------------- |
| `Detection.human()`   | Pedestrian counting |
| `Detection.vehicle()` | Vehicle counting    |

---

### `DetectionParams`

Tuning parameters for the vision tracking pipeline. Mirrors `VisionParams` from `flutter_vision` but lives in `core_domain` to avoid cross-package coupling.

| Field                              | Default | Description                                                        |
| ---------------------------------- | ------- | ------------------------------------------------------------------ |
| `trackHighThresh`                  | `0.6`   | Confidence needed for the first high-confidence association pass   |
| `trackLowThresh`                   | `0.05`  | Minimum confidence considered at all; lower values are ignored     |
| `newTrackThresh`                   | `0.75`  | Confidence required to spawn a brand new track after matching      |
| `trackBuffer`                      | `180`   | Lost-track retention window in 30-FPS-equivalent frames            |
| `maxMatchDistance`                 | `0.8`   | Max fused assignment cost accepted in the first pass               |
| `proximityThresh`                  | `0.9`   | IoU-distance mask threshold for poor-overlap pairs `(1 - IoU)`     |
| `appearanceThresh`                 | `0.5`   | Max embedding distance before appearance matching is masked out    |
| `frameRate`                        | `30`    | Expected input frame rate for timing and track timeout scaling     |
| `lambda`                           | `0.990` | Blend factor between appearance cost and motion distance           |
| `softMotionGating`                 | `true`  | Blend motion distance softly instead of hard-rejecting gated pairs |
| `preferAppearanceFallbackOnLowIou` | `true`  | Let appearance rescue poor-IoU pairs instead of muting appearance  |
| `trackletMinPresenceTimeSec`       | `1.2`   | Minimum elapsed time before assigning a visible tracklet id        |
| `trackletEdgeZoneRatio`            | `0.05`  | Edge margin ratio applied to the smaller image dimension           |
| `trackletEdgeZoneMinPx`            | `32`    | Minimum pixel floor for the edge-zone margin                       |
| `trackletEdgeOverrideTimeSec`      | `2.0`   | Time after which edge-zone tracks may still get a tracklet id      |

---

### `DeliveryConfig`

Tuning parameters for the telemetry upload pipeline.
Data rate assumption: 1 record per 5 min → 12 records/hour, ~100–200 B each.

| Field              | Default | Description                                                           |
| ------------------ | ------- | --------------------------------------------------------------------- |
| `intervalMin`      | `60`    | How often to upload, in minutes                                       |
| `retryIntervalMin` | `5`     | Wait before retrying a failed upload, in minutes                      |
| `maxQueueLength`   | `8640`  | Max queued records before oldest are dropped (12/hr × 24h × 30 days)  |
| `maxBatchSize`     | `1008`  | Max records per upload request (3.5 days; reduces API call frequency) |
| `timeoutSec`       | `30`    | HTTP timeout per request, in seconds                                  |

---

### `Invitation`

Transient payload returned from the invitation server when a valid code is redeemed. Not persisted — consumed once during onboarding to populate `AppState` and runtime auth state.

| Field                | Type                 | Description                                          |
| -------------------- | -------------------- | ---------------------------------------------------- |
| `businessDataServer` | `BusinessDataServer` | Business endpoint metadata carried by the invitation |
| `bearerToken`        | `String`             | Auth token for API requests                          |
| `deviceName`         | `String`             | Human-readable device identifier                     |
| `instruction`        | `String`             | Onboarding message shown post-invite                 |
| `detection`          | `Detection`          | Detection type assigned by the server                |
| `detectionParams`    | `DetectionParams`    | Tracking tuning assigned by the server               |
| `deliveryConfig`     | `DeliveryConfig`     | Upload pipeline config assigned by the server        |

---

### `UploadResult`

Transient server response after a telemetry upload. Not persisted. Optionally carries updated configuration that the server wants to push to the client, removing the need for manual on-device changes.

| Field             | Type               | Description                                              |
| ----------------- | ------------------ | -------------------------------------------------------- |
| `isSuccess`       | `bool`             | Whether the server accepted the upload                   |
| `message`         | `String?`          | Optional human-readable info or error detail             |
| `detection`       | `Detection?`       | If non-null, client should apply this detection override |
| `detectionParams` | `DetectionParams?` | If non-null, client should apply these tracking params   |
| `deliveryConfig`  | `DeliveryConfig?`  | If non-null, client should apply these upload params     |

---

## Generated files

Each model with `@freezed` produces companion files that must not be edited manually:

| Generated file   | Source                                                              |
| ---------------- | ------------------------------------------------------------------- |
| `*.freezed.dart` | `freezed` — value equality, `copyWith`, pattern matching            |
| `*.g.dart`       | `json_serializable` — `fromJson` / `toJson` (persisted models only) |

Regenerate after changing any model:

```bash
dart run build_runner build --delete-conflicting-outputs
```
