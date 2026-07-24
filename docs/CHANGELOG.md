# Changelog

All notable changes to the Piyuo Counter payload format are documented
in this file.

The format follows a simple versioning strategy based on the `schema`
field included in every upload.

------------------------------------------------------------------------

## Schema 1 (2026-07-14)

Initial public release.

### Added

-   Hourly JSON upload container.
-   `schema` field for payload versioning.
-   `deviceId` device identifier.
-   Optional `projectId` and `assignId`.
-   Support for multiple 5-minute payloads per upload.
-   Per-payload quality metrics:
    -   `frameCount`
    -   `missingSec`
    -   `confidence`
    -   `coverage`
    -   `fps`
    -   `isPartial`
-   Per-area traffic statistics:
    -   `passBy`
    -   `stay`
    -   `entry`
    -   `exit`
    -   `appear`
    -   `disappear`
    -   `avgOccupancy`
    -   `maxOccupancy`
    -   `avgDwellSec`
    -   `maxDwellSec`
-   Global area (`areaId = 0`) always included.
-   JSON Schema (`payload-schema-v1.json`).
-   Human-readable documentation (`payload-format.md`).
-   Example payload (`payload-example.json`).

### Compatibility

-   This is the first published schema.
-   Future schema versions should increment the `schema` value.
-   New optional fields may be added without changing the schema version
    if they are backward compatible.
-   Breaking changes require a new schema version.

------------------------------------------------------------------------

## Versioning Policy

### Backward-compatible changes

These changes may be introduced without breaking existing integrations:

-   Adding new optional fields.
-   Clarifying documentation.
-   Adding new examples.
-   Improving descriptions.

### Breaking changes

The following require a new schema version:

-   Renaming a field.
-   Removing a field.
-   Changing a field's type.
-   Changing the meaning of a field.
-   Changing required fields.
-   Changing timestamp formats.

------------------------------------------------------------------------

## Upgrade Guide

When a new schema version is released:

1.  Check the `schema` field.
2.  Validate against the matching JSON Schema.
3.  Update your parser if required.
4.  Continue accepting older schema versions during migration whenever
    practical.
