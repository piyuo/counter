# Piyuo Counter Payload Format

Version: Schema 2

---

## Overview

Piyuo Counter performs all AI detection and tracking locally on the device.

To protect privacy, the application **never uploads video, images, or object identities**. Instead, it summarizes AI detection results into **5-minute counting windows**. Each summary is an **Observation**.

Every hour, the device uploads all observations generated during that hour as a single JSON document.

For example:

| Time          | Generated                           |
| ------------- | ----------------------------------- |
| 07:00 – 07:05 | Observation #1                      |
| 07:05 – 07:10 | Observation #2                      |
| ...           | ...                                 |
| 07:55 – 08:00 | Observation #12                     |
| 08:00         | Upload all 12 observations together |

If the device is offline, observations remain safely stored on the device and will be uploaded automatically when connectivity is restored.

---

## Privacy

Piyuo Counter is designed with privacy in mind.

The uploaded data **does not contain**:

- Video
- Images
- Audio
- Face recognition data
- Personally identifiable information (PII)
- Object tracking IDs

Only aggregated statistics are transmitted.

---

## Upload Example

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
          "dwellMaxSeconds": 122.0
        }
      ],
      "frameCount": 2963
    }
  ]
}
```

For this occupancy example, the samples include 31 zeroes, 2,931 ones, and one two. Their sum is 2,933, while their squared sum is 2,935.

---

## Top-Level Object

| Field        | Type                 | Description                                                              |
| ------------ | -------------------- | ------------------------------------------------------------------------ |
| schema       | Integer              | Payload format version.                                                  |
| deviceId     | String               | Unique identifier of the device generating the observations.             |
| projectId    | String               | Project identifier assigned to the device. Present only when configured. |
| assignId     | String               | Assignment identifier. Present only when configured.                     |
| observations | Array\<Observation\> | List of 5-minute observations included in this upload.                   |

---

## Observation Object

Each observation represents one **5-minute counting window**.

| Field                 | Type          | Description                                                                       |
| --------------------- | ------------- | --------------------------------------------------------------------------------- |
| granularity           | String        | Aggregation interval; uploads contain `minutes5`.                                 |
| year                  | Integer       | Four-digit business year.                                                         |
| month                 | Integer       | Business month, from 1 to 12.                                                     |
| day                   | Integer       | Business day of month.                                                            |
| hour                  | Integer       | Business hour, from 0 to 23.                                                      |
| minute                | Integer       | Business minute.                                                                  |
| confidenceRatioSum    | Number        | Sum of tracked-object confidence ratios (each 0–1), preserving fractional values. |
| confidenceSampleCount | Integer       | Number of tracked-object confidence samples.                                      |
| confidenceRatio       | Number        | Confidence ratio derived from sum and count; rounded to at most 2 decimal places. |
| coveredSeconds        | Integer       | Seconds with valid detection data in this observation.                            |
| expectedSeconds       | Integer       | Expected duration, in seconds, for this observation.                              |
| coverageRatio         | Number        | Valid-data fraction derived from seconds; rounded to at most 2 decimal places.    |
| areas                 | Array\<Area\> | Additive metrics for each configured area.                                        |
| frameCount            | Integer       | Total video frames processed during this observation.                             |

---

## Area Object

Each observation contains one or more area objects.

Area **0** always represents the **Global** area covering the entire camera view.

Additional configured interest areas are included after the global area.

| Field                     | Type    | Description                                                                               |
| ------------------------- | ------- | ----------------------------------------------------------------------------------------- |
| areaId                    | Integer | Area identifier. Area `0` always represents the global area.                              |
| areaName                  | String  | Configured area name.                                                                     |
| passBy                    | Integer | Unique tracks that contacted the area.                                                    |
| stagnant                  | Integer | Unique tracks that met the configured stay threshold.                                     |
| entry                     | Integer | Tracks first observed outside and later inside.                                           |
| exit                      | Integer | Tracks first observed inside and later outside.                                           |
| appear                    | Integer | Newly detected tracks appearing in the area.                                              |
| disappear                 | Integer | Tracks lost after last being seen in the area.                                            |
| occupancySampleCount      | Integer | Number of occupancy samples.                                                              |
| occupancySampleSum        | Integer | Sum of occupancy samples.                                                                 |
| occupancySampleSumSquares | Integer | Sum of squared occupancy samples, used with the count and sum to derive variance.         |
| occupancyMean             | Number  | Average occupancy derived from sample sum and count; rounded to at most 2 decimal places. |
| occupancyMax              | Integer | Highest occupancy sample.                                                                 |
| occupancyLast             | Integer | Most recent occupancy sample for this area.                                               |
| dwellSumSeconds           | Integer | Sum of completed visit durations in whole seconds.                                        |
| dwellSampleCount          | Integer | Number of completed visits; each visit is recorded once disappearance is confirmed.       |
| dwellMeanSeconds          | Number  | Average completed visit duration derived from sum and count; rounded to 2 decimal places. |
| dwellMaxSeconds           | Number  | Longest completed visit in whole seconds.                                                 |
| dwellHistogram            | Array   | Completed visits in `<5s`, `5-15s`, `15-60s`, `1-5min`, and `>=5min` buckets.             |
| presenceTrackCount        | Integer | Number of tracks present in the area during this observation.                             |
| presenceSumSeconds        | Integer | Total track-seconds spent inside the area during this observation.                        |
| presenceMeanSeconds       | Number  | Average presence duration per present track, rounded to at most 2 decimal places.         |

Each histogram bucket includes its lower edge and excludes its upper edge. A visit is
attributed to the observation where the disappear threshold is confirmed; time spent
waiting for that threshold is not included in the visit duration. The histogram is
optional when reading older payloads and, when present, contains exactly five counts.

---

## Upload Behavior

- One observation represents one 5-minute counting window.
- A normal hour produces **12 observations**.
- Multiple observations are uploaded together in a single HTTP request.
- Observations are uploaded approximately once per hour.
- If uploading fails, observations remain on the device and are retried automatically.
- Observations are uploaded in chronological order.

---

## Time Components

`year`, `month`, `day`, `hour`, and `minute` use the monitored location's
business wall clock. On daylight-saving fall-back nights, a local time can
occur twice; the first saved observation wins.

---

## Data Quality Metrics

The following fields help evaluate the quality of each counting window.

| Fields                                     | Description                                                                        |
| ------------------------------------------ | ---------------------------------------------------------------------------------- |
| confidenceRatioSum / confidenceSampleCount | Values used to derive confidenceRatio as a 0–1 average.                            |
| coveredSeconds / expectedSeconds           | Values used to derive coverageRatio across aggregated observations.                |
| frameCount                                 | Total processed frames. Higher values generally indicate more complete processing. |

---

## Notes

- Dates and times use the monitored location's business wall clock.
- Numeric values may contain decimal fractions where appropriate.
- Convenience averages are transmitted; sums and counts remain the source of truth.
- Future schema versions will increment the `schema` field.

---

## Schema Version

Current payload schema:

``` bash
schema = 2
```

Servers should validate the `schema` field before processing uploaded data.

Schema 2 uses the per-area `stagnant` event-count field, explicit second and
ratio names, and date/time components. Optional convenience averages are
included; sums and counts remain the source of truth.

Future versions may introduce additional fields while preserving compatibility with previous schema versions whenever practical.
