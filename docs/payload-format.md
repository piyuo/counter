# Piyuo Counter Payload Format

**Schema Version:** 2

---

## 1. Overview

Piyuo Counter performs AI detection and tracking locally on the device.

The application summarizes detection and tracking results into **5-minute observations**. Observations contain counting events, occupancy statistics, visit durations, presence statistics, and data-quality metrics.

Every hour, the device normally uploads the observations generated during that hour as a single JSON document.

For example:

| Time        | Generated                           |
| ----------- | ----------------------------------- |
| 07:00–07:05 | Observation 1                       |
| 07:05–07:10 | Observation 2                       |
| ...         | ...                                 |
| 07:55–08:00 | Observation 12                      |
| 08:00       | Upload the 12 observations together |

If the device is offline, observations remain stored locally and are retried automatically when connectivity permits.

### Observation granularity

Schema 2 uploads contain 5-minute observations (`granularity: "minutes5"`).

The same observation model is also used internally for hourly, daily, monthly, and yearly aggregation. Those aggregated observations are not part of the Schema 2 upload contract.

---

## 2. Privacy

All AI detection and tracking are performed locally on the device.

Uploaded payloads do not contain:

- Video, images, or audio
- Facial recognition data
- Personally identifiable information (PII)
- Object tracking IDs

Only counting statistics and associated metadata are transmitted.

Counts are based on object tracking, not verified identities. A tracking ID change, tracker reset, or other tracking discontinuity may cause the same physical person or vehicle to be counted again.

---

## 3. Upload Example

```json
{
  "schema": 2,
  "deviceId": "041bfec6-8923-4b09-be5f-0fd11d3df7f5",
  "observations": [
    {
      "granularity": "minutes5",
      "year": 2026,
      "month": 7,
      "day": 13,
      "hour": 19,
      "minute": 20,
      "confidenceRatioSum": 2572.21,
      "confidenceSampleCount": 2963,
      "confidenceRatio": 0.87,
      "coveredSeconds": 123,
      "expectedSeconds": 300,
      "coverageRatio": 0.41,
      "areas": [
        {
          "areaId": 0,
          "areaName": "Global",
          "passBy": 1,
          "stagnant": 0,
          "entry": 0,
          "exit": 0,
          "appear": 0,
          "disappear": 0,
          "occupancySampleCount": 2963,
          "occupancySampleSum": 2933,
          "occupancySampleSumSquares": 2935,
          "occupancyMean": 0.99,
          "occupancyMax": 2,
          "occupancyLast": 1,
          "dwellSumSeconds": 6070,
          "dwellSampleCount": 100,
          "dwellMeanSeconds": 60.7,
          "dwellMaxSeconds": 122,
          "dwellHistogram": [10, 20, 30, 25, 15],
          "presenceTrackCount": 1,
          "presenceSumSeconds": 1,
          "presenceMeanSeconds": 1.0
        }
      ],
      "frameCount": 2963
    }
  ]
}
```

The numerical values in this example illustrate the payload structure; they are not intended to represent a fully validated, internally consistent observation.

For example, the occupancy samples in the example sum to 2,933, and their squared values sum to 2,935.

---

## 4. Top-Level Object

| Field          | Type                 | Description                                                     |
| -------------- | -------------------- | --------------------------------------------------------------- |
| `schema`       | Integer              | Payload schema version. Required.                               |
| `deviceId`     | String               | Identifier of the device generating the observations. Required. |
| `projectId`    | String               | Project identifier, present only when configured.               |
| `assignId`     | String               | Assignment identifier, present only when configured.            |
| `observations` | Array of Observation | 5-minute observations included in this upload. Required.        |

Optional fields may be absent when they are not configured. Consumers must not assume that every optional field is present.

The `observations` array is ordered chronologically according to the business wall-clock timestamps.

---

## 5. Observation Object

Each observation represents one 5-minute counting window.

| Field                   | Type                 | Description                                                     |
| ----------------------- | -------------------- | --------------------------------------------------------------- |
| `granularity`           | String               | Aggregation interval. Schema 2 uploads use `minutes5`.          |
| `year`                  | Integer              | Four-digit business year.                                       |
| `month`                 | Integer              | Business month, 1–12.                                           |
| `day`                   | Integer              | Business day of month.                                          |
| `hour`                  | Integer              | Business hour, 0–23.                                            |
| `minute`                | Integer              | Starting minute of the observation, normally 0, 5, 10, ..., 55. |
| `confidenceRatioSum`    | Number               | Sum of tracked-object confidence ratios.                        |
| `confidenceSampleCount` | Integer              | Number of confidence samples.                                   |
| `confidenceRatio`       | Number               | Mean confidence ratio derived from the sum and count.           |
| `coveredSeconds`        | Integer              | Seconds with valid detection data.                              |
| `expectedSeconds`       | Integer              | Expected duration of the observation, normally 300 seconds.     |
| `coverageRatio`         | Number               | Valid-data fraction derived from covered and expected seconds.  |
| `areas`                 | Array of AreaMetrics | Metrics for the global area and configured interest areas.      |
| `frameCount`            | Integer              | Total number of frames processed during the observation.        |

### Confidence metrics

Confidence ratios are in the range 0.0–1.0.

The mean confidence ratio is calculated as:

`confidenceRatio = confidenceRatioSum / confidenceSampleCount`

If there are no samples, the mean is zero.

`confidenceRatioSum` and `confidenceSampleCount` are the source values. `confidenceRatio` is a convenience value.

The exact definition of a confidence sample follows the producing application's tracking implementation. Consumers should not interpret the sample count as a count of unique people or vehicles.

### Coverage metrics

Coverage describes the fraction of the expected observation duration during which detection data was valid.

`coverageRatio = coveredSeconds / expectedSeconds`

If `expectedSeconds` is zero, the ratio is zero.

For a normal 5-minute observation, `expectedSeconds` is 300. `coveredSeconds` may be lower because of missing detection data, camera interruptions, or other processing gaps.

Coverage ratio is rounded to at most two decimal places in JSON. Use the seconds fields when calculating aggregate coverage.

### Frame count

`frameCount` is the number of processed video frames during the observation.

Frame count alone does not establish data completeness. Interpret it alongside `coveredSeconds`, `expectedSeconds`, and `coverageRatio`.

---

## 6. AreaMetrics Object

Each observation contains metrics for the Global area and configured interest areas.

Area `0` always represents the Global area covering the monitored camera scene. Additional areas represent configured interest areas.

| Field                       | Type             | Description                                                                                           |
| --------------------------- | ---------------- | ----------------------------------------------------------------------------------------------------- |
| `areaId`                    | Integer          | Configured area identifier; `0` represents Global.                                                    |
| `areaName`                  | String           | Configured area name.                                                                                 |
| `passBy`                    | Integer          | Tracks counted on first contact with the area.                                                        |
| `stagnant`                  | Integer          | Tracks reaching the configured stagnant threshold.                                                    |
| `entry`                     | Integer          | Tracks first observed outside and later inside a local area.                                          |
| `exit`                      | Integer          | Tracks first observed inside and later outside a local area.                                          |
| `appear`                    | Integer          | Tracks first detected with their center inside the area.                                              |
| `disappear`                 | Integer          | Tracks last seen inside the area and subsequently absent long enough to meet the disappear threshold. |
| `occupancySampleCount`      | Integer          | Number of occupancy samples.                                                                          |
| `occupancySampleSum`        | Integer          | Sum of occupancy sample values.                                                                       |
| `occupancySampleSumSquares` | Integer          | Sum of squared occupancy sample values.                                                               |
| `occupancyMean`             | Number           | Mean occupancy per sample.                                                                            |
| `occupancyMax`              | Integer          | Maximum occupancy sample.                                                                             |
| `occupancyLast`             | Integer          | Most recent occupancy sample.                                                                         |
| `dwellSumSeconds`           | Integer          | Sum of completed visit durations in whole seconds.                                                    |
| `dwellSampleCount`          | Integer          | Number of completed visits recorded.                                                                  |
| `dwellMeanSeconds`          | Number           | Mean duration of completed visits.                                                                    |
| `dwellMaxSeconds`           | Integer          | Longest completed visit in whole seconds.                                                             |
| `dwellHistogram`            | Array of Integer | Completed visit counts across five duration buckets.                                                  |
| `presenceTrackCount`        | Integer          | Number of tracks present for a positive duration during this observation.                             |
| `presenceSumSeconds`        | Integer          | Total track-seconds spent inside the area during this observation.                                    |
| `presenceMeanSeconds`       | Number           | Mean presence duration per present track during this observation.                                     |

### 6.1 Event metrics

Event metrics count tracking events, not verified unique people or vehicles.

The same track is counted at most once for a given event while its tracking history is retained. If a new tracking ID is created after an ID switch, history eviction, tracker reset, or application restart, the same physical object may be counted again.

**`passBy`**

Counts a track when it first contacts an area. It is recorded in the observation where the first contact occurs, not in every subsequent observation while the track remains present.

**`stagnant`**

Counts a track when it has remained inside an area continuously for at least the configured stagnant threshold.

Absences shorter than the configured disappear threshold do not restart the clock. The event is attributed to the observation in which the stagnant threshold is reached.

**`entry` and `exit`**

These metrics apply only to local interest areas. Entry means a track was initially outside the area and was later observed inside. Exit means a track was initially inside and was later observed outside.

The Global area always reports zero for these metrics.

**`appear` and `disappear`**

`appear` counts tracks first detected with their center inside the area.

`disappear` counts tracks that were last seen inside the area and then remained absent long enough to meet the configured disappear threshold.

For the Global area, disappearance means the track was lost from scene tracking; it does not confirm that the object physically exited the camera view.

For a local area, disappearance can also occur when a track leaves that area but remains visible elsewhere.

A visit closed because of source dropout, pause, clock jump, or monitoring stop does not count as a disappear event.

### 6.2 Occupancy metrics

Occupancy describes the number of tracked objects present in an area at each sample.

**`occupancySampleCount`**

The number of occupancy samples. In the current implementation, occupancy is sampled once per processed frame, so this count equals `frameCount`.

**`occupancySampleSum` and `occupancySampleSumSquares`**

These preserve the information needed to calculate the mean and variance without retaining individual samples.

The mean is:

`occupancyMean = occupancySampleSum / occupancySampleCount`

The population variance can be calculated as:

`variance = occupancySampleSumSquares / occupancySampleCount - mean²`

If there are no samples, the mean and variance are zero. Small negative variance caused by floating-point rounding should be treated as zero.

**`occupancyMax`**

The highest occupancy sample observed during the window.

**`occupancyLast`**

The latest occupancy sample. For aggregation, retain the value from the latest child observation.

Occupancy mean is a per-sample average, not a time-weighted average. Differences in sampling frequency can affect comparisons between observations.

### 6.3 Dwell metrics

Dwell describes the duration of a completed visit.

A visit is considered finished when the track has been absent from the area for the configured disappear threshold. The visit is recorded once, in the observation where its completion is confirmed.

The duration excludes the waiting time needed to confirm disappearance.

For example, a visit from 12:03 to 12:13 contributes 600 seconds to the observation in which the visit is confirmed finished, rather than being distributed across the observations in which the visitor was present.

A visit spanning midnight is attributed to the day on which it finishes.

An open visit is not converted into dwell when observation ends. If monitoring stops, pauses, loses its source, or encounters a clock jump, the incomplete visit is discarded because the interruption does not establish when the track actually left. Resetting or changing interest areas also discards open visits. Discarded visits do not create a dwell sample or contribute to `dwellSumSeconds`, `dwellSampleCount`, `dwellMaxSeconds`, or `dwellHistogram`; only visits completed by a confirmed disappearance contribute to these metrics. Other completed visits in the same observation remain included.

**`dwellSumSeconds` and `dwellSampleCount`**

These are the source values for the mean completed-visit duration:

`dwellMeanSeconds = dwellSumSeconds / dwellSampleCount`

If there are no completed visits, the mean is zero.

**`dwellMaxSeconds`**

The longest completed visit recorded during the observation.

**`dwellHistogram`**

The histogram contains exactly five counts when present:

| Index | Duration range                      |
| ----- | ----------------------------------- |
| 0     | Less than 5 seconds                 |
| 1     | 5 seconds to less than 15 seconds   |
| 2     | 15 seconds to less than 60 seconds  |
| 3     | 60 seconds to less than 300 seconds |
| 4     | 300 seconds or longer               |

Each bucket includes its lower boundary and excludes its upper boundary.

When present, the bucket counts must sum to `dwellSampleCount`.

The histogram is additive: aggregate it by adding corresponding bucket counts.

### 6.4 Presence metrics

Presence measures time spent inside an area during each observation. It is different from completed-visit dwell.

**`presenceTrackCount`**

Counts tracks present for a positive duration during the observation. A track continuing across several observations contributes separately to each observation.

Consequently, this field is not a count of distinct tracks across a longer period.

**`presenceSumSeconds`**

The total time spent inside the area by all tracks during the observation, expressed in whole track-seconds.

For example, a track present from 12:03 to 12:13 contributes approximately:

- 120 seconds to 12:00–12:05
- 300 seconds to 12:05–12:10
- 180 seconds to 12:10–12:15

Actual values depend on valid observation intervals and whole-second rounding.

When `coveredSeconds` is positive, the ratio of `presenceSumSeconds` to `coveredSeconds` estimates the time-weighted average number of tracks present while detection data was valid.

**`presenceMeanSeconds`**

The mean presence duration per present track within the observation:

`presenceMeanSeconds = presenceSumSeconds / presenceTrackCount`

If there are no present tracks, the mean is zero.

This value is not the average length of a completed visit. Use the dwell metrics for completed-visit duration.

---

## 7. Aggregation Rules

The same observation model is used internally at multiple aggregation levels. Correct aggregation requires combining the underlying values according to their semantics.

### 7.1 Additive fields

Sum the following fields across child observations:

- `confidenceRatioSum`
- `confidenceSampleCount`
- `coveredSeconds`
- `expectedSeconds`
- `frameCount`
- Event counts: `passBy`, `stagnant`, `entry`, `exit`, `appear`, and `disappear`
- `occupancySampleCount`
- `occupancySampleSum`
- `occupancySampleSumSquares`
- `dwellSumSeconds`
- `dwellSampleCount`
- `presenceTrackCount`
- `presenceSumSeconds`

Sum `dwellHistogram` element by element.

### 7.2 Derived averages and ratios

Recalculate convenience values from the aggregated source fields.

| Field                 | Aggregation formula                          |
| --------------------- | -------------------------------------------- |
| `confidenceRatio`     | `confidenceRatioSum / confidenceSampleCount` |
| `coverageRatio`       | `coveredSeconds / expectedSeconds`           |
| `occupancyMean`       | `occupancySampleSum / occupancySampleCount`  |
| `dwellMeanSeconds`    | `dwellSumSeconds / dwellSampleCount`         |
| `presenceMeanSeconds` | `presenceSumSeconds / presenceTrackCount`    |

If the corresponding denominator is zero, the derived value is zero.

**Do not average the averages or ratios of child observations.** Aggregate their underlying sums and counts first, then calculate the derived value.

Convenience averages and ratios are rounded to at most two decimal places when serialized to JSON. The underlying integer sums and counts remain the source of truth.

### 7.3 Maximum and latest-value fields

| Field             | Aggregation rule                         |
| ----------------- | ---------------------------------------- |
| `occupancyMax`    | Maximum value among child observations.  |
| `dwellMaxSeconds` | Maximum value among child observations.  |
| `occupancyLast`   | Value from the latest child observation. |

### 7.4 Area identity

Aggregate metrics only for matching area identities.

`areaId` identifies the area. `areaName` is descriptive metadata. If area configuration changes over time, consumers should not assume that an identical numeric ID always represents an unchanged physical region unless the application's configuration rules guarantee it.

### 7.5 Missing observations

A missing observation does not mean that zero traffic occurred.

Consumers should distinguish between:

- An observed zero count
- An observation with partial coverage
- A missing observation
- A period with no usable data

Missing windows must not be silently synthesized as zero-count observations. Aggregated coverage must reflect the actual observed intervals.

---

## 8. Time Semantics and Daylight Saving Time

The `year`, `month`, `day`, `hour`, and `minute` fields represent the monitored location's **business local wall-clock time**, not UTC.

This allows businesses in different time zones to compare the same local operating hours, such as 11:00–13:00.

The date/time fields do not include a UTC timestamp or time-zone offset. Consumers cannot reliably reconstruct the absolute UTC instant from these fields alone.

### 8.1 Daylight-saving fall-back

When the local clock repeats an hour, two observations may have the same date and time components.

The Analytics Engine applies a first-saved-wins rule: an observation already stored for the same granularity and date/time is not overridden by a later duplicate.

Traffic recorded during the repeated hour's second occurrence may therefore be lost.

### 8.2 Daylight-saving spring-forward

When the local clock skips an interval, no observations exist for the skipped local times.

The missing intervals are not filled with placeholder observations. Aggregations are calculated from the observations that actually exist.

### 8.3 Clock and time-zone changes

Device clock changes and time-zone changes can also create discontinuities or duplicate local timestamps.

Consumers should not assume that business wall-clock timestamps always map one-to-one to absolute time.

The first-saved-wins behavior is enforced by the Analytics Engine when inserting observations into storage; it is not enforced by the observation data model itself.

---

## 9. Data Quality and Interpretation

The following fields help evaluate whether an observation is suitable for analysis.

| Fields                                         | Interpretation                                             |
| ---------------------------------------------- | ---------------------------------------------------------- |
| `coveredSeconds` / `expectedSeconds`           | Amount of the expected interval with valid detection data. |
| `coverageRatio`                                | Convenience ratio describing temporal coverage.            |
| `frameCount`                                   | Number of processed frames; interpret alongside coverage.  |
| `confidenceRatioSum` / `confidenceSampleCount` | Source values used to calculate mean detection confidence. |

A high coverage ratio does not guarantee perfect detection accuracy. Likewise, a high confidence ratio does not establish that all objects were detected.

Consumers should apply their own minimum data-quality requirements before comparing periods or presenting business insights.

A zero count with valid coverage is different from a missing or unusable observation. No data must not be interpreted as zero traffic.

---

## 10. Upload Behavior

- Each uploaded observation represents a 5-minute counting window.
- A normal hour produces 12 observations.
- The device normally uploads approximately once per hour.
- Multiple observations are sent together in one HTTP request.
- Failed uploads are retried automatically.
- Observations are uploaded in chronological order.
- Offline observations are retained locally until they can be uploaded, subject to the application's retention policy.

Upload timing may vary because of connectivity, application lifecycle, or device availability. Consumers should not assume that an observation arrives immediately after its 5-minute window ends.

---

## 11. Schema Compatibility

The top-level `schema` field identifies the payload format version.

Schema 2 uses:

- Per-area `stagnant` event counts
- Explicit second-based duration field names
- Confidence and coverage ratio fields
- Business-local date/time components
- Whole-second `presenceSumSeconds`
- Optional convenience averages that can be recomputed from sums and counts

### 11.1 Schema 2 validation

A Schema 2 consumer should:

1. Validate the `schema` value before processing the payload.
2. Validate required top-level fields and field types.
3. Validate each observation's required fields and each area's required fields.
4. Treat optional fields according to their documented defaults and compatibility rules.
5. Avoid interpreting missing observations as zero counts.

Unknown schema versions must not be silently interpreted as Schema 2. Consumers should reject unsupported versions or handle them through an explicit compatibility mechanism.

### 11.2 Optional fields and legacy payloads

When reading legacy payloads, `dwellHistogram` may be absent. A consumer supporting those payloads may treat the missing histogram as unavailable rather than assuming that no visits occurred.

For Schema 2 writers, the histogram should be serialized according to the Schema 2 contract. When present, it must contain exactly five non-negative integer counts.

Optional convenience averages should not replace the source sums and counts.

### 11.3 Future versions

Future schema versions may introduce or change fields. Compatibility behavior must be defined explicitly for each version.

Consumers should not assume that an unknown schema version is compatible simply because its JSON structure resembles Schema 2.

---

## 12. Numeric Precision

Integer counters and durations are serialized as integers.

Ratio and average fields may contain decimal fractions and are rounded to at most two decimal places when written to JSON.

Consumers should use source sums and counts to recompute derived averages and ratios when precision matters.

Floating-point JSON values should be interpreted as numeric values, not as strings.

---

## 13. Schema Version

The current payload schema is:

```bash
schema = 2
```

Schema 2 uploads contain 5-minute observations and their per-area metrics.

Servers must validate the schema version before processing uploaded data and must not silently interpret unsupported versions as Schema 2.
