<!--
============================================================================
Table of Contents
============================================================================
1. Overview
2. Core Concepts
3. Windowing Rules
4. States and Lifecycle
5. Stall Handling Policy
6. Coverage Ratio
7. Partial Windows
8. Timers and Finalization
9. Integration Points
10. Operational Guarantees
============================================================================
-->

# Counting System Design

## 1. Overview

This module implements a long-running, stable, 5‑minute window counter for pedestrian/vehicle tracking. It is designed as a stateful sensor that produces windowed summaries of events and occupancy statistics while remaining robust over days or months of uptime.

Key goals:

- Fixed 5‑minute window alignment
- Always-on 24/7 sensor semantics
- Safe handling of frame stalls
- Deterministic finalization independent of frame callbacks

## 2. Core Concepts

### Counter

- Acts as the central orchestrator mapping `VisionSourceStatus` and frame data to the appropriate sub-components.
- Pushes track data to `AreaTracker`s and routes time instructions to the `CountWindowScheduler`.

### CountWindowScheduler

- Handles all temporal logic including 5-minute alignments, stall handling (via timers), clock-jump handling, and triggering window finalizations.

### AreaTracker

- Evaluates spatial boundaries (e.g., entered, exited, passBy) for a specific `InterestArea` or the global screen.
- Maintains histories of observed object IDs to ensure accurate counts.

### CountWindowAggregator

- Stores per-window event counts and state metrics.
- Produces a `WindowCountState` at finalization.

### WindowCountState

- `startUtc`, `endUtc`: fixed 5‑minute window boundaries.
- `areas`: per-area metrics.
- `areas[*].currentOccupancy`: latest sampled occupancy in the window.
- `areas[*].avgOccupancy`: simple average across sampled occupancies.
- `areas[*].maxOccupancy`: max sampled occupancy in the window.
- `coverageRatio`: fraction of window with valid data (1.0 = full coverage).
- `missingDuration`: exact accumulated duration of missing input in this window.

## 3. Windowing Rules

Windows are aligned to wall‑clock 5‑minute boundaries:

- 00:00–00:05
- 00:05–00:10
- 00:10–00:15

When a window ends, the system finalizes and emits a `WindowCountState`.

## 4. States and Lifecycle

The counter follows a sensor model:

- **Running**: counting + reporting on schedule.
- **Stopped/Closed**: reset internal trackers for a new session.

`Counter.onInterestAreasChanged(areas)`

- Clears per-area tracking state.
- Discards the active window.
- Starts a new partial window on the next frame.

## 5. Stall Handling Policy

The counter responds to source status updates:

### Short Stall (< 5s)

- Ignore. Continue without penalty.

### Medium Stall (5s–1m)

- Keep the active window.
- Mark missing time as uncovered.
- `coverageRatio` reflects the gap.

### Long Stall (> 1m) or Fatal Error

- Keep the window timeline continuous.
- Account downtime via `missingDuration`.
- Continue finalization on 5-minute boundaries.

Events are handled via:

- `Counter.handleSourceStatus(VisionSourceStatus)`

## 6. Coverage Ratio

When a warning span is detected (5s–1m), the counter accumulates missing duration into the window. Finalization produces:

$$
coverageRatio = \max\left(0, \min\left(1, \frac{windowDuration - missingDuration}{windowDuration}\right)\right)
$$

This allows downstream services to scale or reject partial data based on coverage.

## 7. Partial Windows

Partial windows occur when a new window starts after delayed input:

- First window after source start may be partial.
- Continuity tolerance: gaps ≤ 2s are treated as continuous (not partial).

## 8. Timers and Finalization

Finalization does not depend on frame callbacks.

- A timer schedules finalization at the next 5‑minute boundary.
- The timer runs continuously and only the counter lifecycle controls emissions.

This ensures deterministic emission even if frames stop flowing while running.

## 9. Integration Points

The counter listens to source events through BaseNotifier:

- `VisionSourceStarted`
- `VisionSourceStopped`
- `VisionSourceReadWarning`
- `VisionSourceReadRecovered`
- `VisionSourceFatalError`

BaseNotifier calls `Counter.handleSourceStatus(...)` to keep logic consistent with the rest of the lifecycle.

When users edit interest areas, BaseNotifier should call:

- `Counter.onInterestAreasChanged(areas)`

## 10. Operational Guarantees

- Windows always align to fixed 5‑minute boundaries.
- No user-controlled pause is part of the counting contract.
- Long stalls or fatal errors are reflected as technical missing coverage.
- Medium stalls degrade coverage but preserve window continuity.
- Finalization occurs on schedule even without frame updates.

## 11. Clock Jump Handling

Wall‑clock time can jump (NTP sync, manual changes). The counter detects large jumps (≥1 minute) and treats them as a reset of the active window:

- Discard the current window.
- Start a new partial window aligned to the current wall‑clock boundary.

This keeps window alignment deterministic while preventing mixed‑time windows.
