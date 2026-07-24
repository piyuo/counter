# Piyuo Counter Payload Format

Version: Schema 1

---

## Overview

Piyuo Counter performs all AI detection and tracking locally on the device.

To protect privacy, the application **never uploads video, images, or object identities**. Instead, it summarizes AI detection results into **5-minute counting windows**. Each summary is called a **Payload**.

Every hour, the device uploads all payloads generated during that hour as a single JSON document.

For example:

| Time          | Generated                       |
| ------------- | ------------------------------- |
| 07:00 – 07:05 | Payload #1                      |
| 07:05 – 07:10 | Payload #2                      |
| ...           | ...                             |
| 07:55 – 08:00 | Payload #12                     |
| 08:00         | Upload all 12 payloads together |

If the device is offline, payloads remain safely stored on the device and will be uploaded automatically when connectivity is restored.

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
  "schema": 1,
  "deviceId": "041bfec6-8923-4b09-be5f-0fd11d3df7f5",
  "payloads": [
    {
      "session": "2607131922",
      "sequence": 1,
      "startUtc": "2026-07-14T02:20:00.000Z",
      "startBusiness": "2026-07-13T19:20:00.000",
      "businessDate": "2026-07-13",
      "frameCount": 2963,
      "missingSec": 177,
      "confidence": 86.92,
      "isPartial": true,
      "coverage": 0.41,
      "fps": 24.2,
      "areas": [
        {
          "areaId": 0,
          "areaName": "Global",
          "passBy": 1,
          "stay": 0,
          "entry": 0,
          "exit": 0,
          "appear": 0,
          "disappear": 0,
          "avgOccupancy": 0.99,
          "maxOccupancy": 1,
          "avgDwellSec": 60.7,
          "maxDwellSec": 122.0
        }
      ]
    }
  ]
}
```

---

## Top-Level Object

| Field     | Type             | Required | Description                                                              |
| --------- | ---------------- | :------: | ------------------------------------------------------------------------ |
| schema    | Integer          |   Yes    | Payload format version.                                                  |
| deviceId  | String           |   Yes    | Unique identifier of the device generating the payload.                  |
| projectId | String           |    No    | Project identifier assigned to the device. Present only when configured. |
| assignId  | String           |    No    | Assignment identifier. Present only when configured.                     |
| payloads  | Array\<Payload\> |   Yes    | List of 5-minute payloads included in this upload.                       |

---

## Payload Object

Each payload represents one **5-minute counting window**.

| Field         | Type                    | Required | Description                                                                 |
| ------------- | ----------------------- | :------: | --------------------------------------------------------------------------- |
| session       | String                  |   Yes    | Counting session identifier.                                                |
| sequence      | Integer                 |   Yes    | Sequential payload number within the session. Starts at 1.                  |
| startUtc      | String (ISO-8601 UTC)   |   Yes    | Start time of the counting window in UTC.                                   |
| startBusiness | String (ISO-8601 Local) |   Yes    | Start time using the business timezone.                                     |
| businessDate  | String                  |   Yes    | Business date in `YYYY-MM-DD` format.                                       |
| frameCount    | Integer                 |   Yes    | Total video frames processed during this window.                            |
| missingSec    | Integer                 |   Yes    | Total seconds of missing video input during this window.                    |
| confidence    | Number                  |   Yes    | Average AI detection confidence (percentage).                               |
| isPartial     | Boolean                 |   Yes    | Indicates whether the window ended before completing the full five minutes. |
| coverage      | Number                  |   Yes    | Fraction of the window containing valid detection data (0.0–1.0).           |
| fps           | Number                  |   Yes    | Average processed frames per second during valid periods.                   |
| areas         | Array\<Area\>           |   Yes    | Statistics for each configured area.                                        |

---

## Area Object

Each payload contains one or more area objects.

Area **0** always represents the **Global** area covering the entire camera view.

Additional configured interest areas are included after the global area.

| Field        | Type    | Required | Description                                                      |
| ------------ | ------- | :------: | ---------------------------------------------------------------- |
| areaId       | Integer |   Yes    | Area identifier. Area `0` always represents the global area.     |
| areaName     | String  |   Yes    | Configured area name.                                            |
| passBy       | Integer |   Yes    | Number of objects that passed through without entering the area. |
| stay         | Integer |   Yes    | Number of objects classified as staying within the area.         |
| entry        | Integer |   Yes    | Number of objects entering the area.                             |
| exit         | Integer |   Yes    | Number of objects leaving the area.                              |
| appear       | Integer |   Yes    | Number of newly detected objects appearing in the area.          |
| disappear    | Integer |   Yes    | Number of tracked objects disappearing from the area.            |
| avgOccupancy | Number  |   Yes    | Average occupancy during the counting window.                    |
| maxOccupancy | Integer |   Yes    | Highest occupancy observed during the counting window.           |
| avgDwellSec  | Number  |   Yes    | Average dwell time in seconds.                                   |
| maxDwellSec  | Number  |   Yes    | Maximum dwell time in seconds.                                   |

---

## Upload Behavior

- One payload represents one 5-minute counting window.
- A normal hour produces **12 payloads**.
- Multiple payloads are uploaded together in a single HTTP request.
- Payloads are uploaded approximately once per hour.
- If uploading fails, payloads remain on the device and are retried automatically.
- Payloads are uploaded in chronological order.

---

## Time Fields

Three time fields are included for different purposes.

| Field         | Purpose                                                                               |
| ------------- | ------------------------------------------------------------------------------------- |
| startUtc      | Canonical timestamp used for synchronization and ordering across devices.             |
| startBusiness | Local business time used for reports and analytics.                                   |
| businessDate  | Business day derived from `startBusiness`, simplifying grouping and database queries. |

---

## Data Quality Metrics

The following fields help evaluate the quality of each counting window.

| Field      | Description                                                                        |
| ---------- | ---------------------------------------------------------------------------------- |
| frameCount | Total processed frames. Higher values generally indicate more complete processing. |
| missingSec | Total duration of missing camera input.                                            |
| coverage   | Portion of the 5-minute window containing valid detection data.                    |
| confidence | Average AI confidence across tracked objects.                                      |
| fps        | Average processing speed during valid periods.                                     |
| isPartial  | Indicates the counting window ended early.                                         |

---

## Notes

- All timestamps use ISO-8601 format.
- `startUtc` always uses UTC (`Z` suffix).
- `startBusiness` uses the configured business timezone.
- Numeric values may contain decimal fractions where appropriate.
- Future schema versions will increment the `schema` field while maintaining backward compatibility whenever possible.

---

## Schema Version

Current payload schema:

``` bash
schema = 1
```

Servers should validate the `schema` field before processing uploaded data.

Future versions may introduce additional fields while preserving compatibility with previous schema versions whenever practical.
