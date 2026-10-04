# Piyuo Counter Onboarding Design Notes

## Overview

This document explains the design decisions behind the 3-page onboarding flow used in Piyuo Counter.

The onboarding is intentionally simple. Its purpose is not to teach every feature or technical detail. Instead, it gives first-time users a clear mental model of:

1. What Piyuo Counter does
2. Why it is privacy-safe
3. How it operates automatically

The onboarding should be understandable within a few seconds per page and fit comfortably on a single screen without scrolling.

---

# Product Background

Piyuo Counter is a real-time pedestrian and vehicle counting application built with Flutter for:

- iOS
- macOS
- Android
- Windows

The application uses:

- Device camera input
- On-device AI object detection
- BOT-SORT object tracking
- Local telemetry storage
- Periodic telemetry uploads

The system continuously analyzes movement and generates aggregated traffic summaries every 5 minutes.

Typical metrics include:

- passBy
- stay
- entry
- exit
- appear
- disappear
- avgOccupancy
- maxOccupancy
- avgDwellSec
- maxDwellSec

These summaries are stored locally and uploaded hourly to either:

- Piyuo Cloud
- Customer-owned infrastructure

The system is designed to behave similarly to an automated telemetry sensor.

---

# Primary Goals of Onboarding

The onboarding flow exists to answer three user questions immediately:

| User Question                         | Onboarding Goal                      |
| ------------------------------------- | ------------------------------------ |
| "What is this app?"                   | Explain AI traffic counting          |
| "Is this surveillance?"               | Explain privacy-first design         |
| "Does this require manual operation?" | Explain automated telemetry workflow |

The onboarding is intentionally focused on high-level concepts rather than implementation details.

---

# Design Philosophy

## Keep Pages Extremely Simple

Each onboarding page should:

- Fit on one screen
- Require no scrolling
- Contain only 2 short text sections
- Include one supporting image
- Be readable in 3–5 seconds

The onboarding is not documentation.

The purpose is orientation, not technical education.

---

# Why We Avoid Technical Jargon

We intentionally avoid terms like:

- BOT-SORT
- payload
- telemetry pipeline
- wall clock alignment
- object tracking IDs
- inference pipeline

Although technically accurate, these terms increase cognitive load and reduce clarity for first-time users.

Most users do not need to understand implementation details to understand the product value.

Instead, onboarding focuses on user outcomes:

- Detect pedestrians and vehicles
- Privacy-safe analytics
- Automatic operation

Technical details belong in:

- Documentation
- Developer guides
- Architecture notes
- Marketing pages
- API references

Not onboarding.

---

# Why We Emphasize Privacy

Privacy concerns are the largest source of hesitation for camera-based analytics products.

Many users immediately assume:

- Video is uploaded
- Faces are analyzed
- People are tracked remotely
- Personal identities are stored

Piyuo Counter is intentionally designed to avoid these problems.

The application only uploads aggregated summaries every 5 minutes.

No raw media leaves the device:

- No video
- No images
- No face data
- No identity tracking

Therefore, onboarding must clearly communicate:

- AI runs locally
- Data is anonymous
- Only aggregated statistics are transmitted

This privacy-first messaging is one of the core product differentiators.

---

# Why We Describe 5-Minute Summaries

The 5-minute summary window is a foundational part of the system design.

Instead of transmitting raw events continuously, the app aggregates observations into fixed windows.

This design provides several advantages:

## Privacy

Aggregation reduces surveillance concerns and helps support privacy-law compliance.

## Reliability

Windowed telemetry is resilient to temporary network failures.

## Efficiency

Small summaries minimize:

- bandwidth usage
- server load
- battery usage
- storage requirements

## Predictability

Fixed intervals make downstream analytics simpler and more stable.

---

# Why We Mention Hourly Uploads

The system uploads data hourly because:

- It reduces network overhead
- It smooths backend load
- It improves battery efficiency
- It supports intermittent connectivity
- It behaves like industrial telemetry systems

The upload cadence is aligned to wall clock time internally, but we intentionally avoid the phrase "wall clock" in onboarding because it is too technical for general users.

Instead, we simply explain:

> "Data summaries are saved every 5 minutes and uploaded hourly."

This communicates the operational behavior without exposing implementation complexity.

---

# Why We Avoid Device-Specific Wording

We intentionally avoid phrases like:

- "Turn your phone into..."
- "Use your tablet as..."
- "Convert your computer into..."

because Apple App Store review guidelines may reject or question wording that does not precisely match the running platform.

Since Piyuo Counter supports multiple platforms, the safest wording is platform-neutral language such as:

- "built-in camera"
- "your device"
- "on-device AI"

This avoids review ambiguity and keeps messaging consistent across platforms.

---

# Why We Use "On-Device AI"

We prefer the phrase:

> "on-device AI"

instead of:

- local AI
- edge AI
- embedded AI

because:

- It is easier for general users to understand
- Apple commonly uses this terminology
- It clearly implies privacy benefits
- It avoids overly technical language

---

# Why We Avoid "Crowd Behavior Analysis"

Earlier onboarding drafts used phrases like:

- "crowd behavior analysis"

We intentionally removed this wording because it may:

- sound invasive
- imply surveillance
- create unnecessary concern
- conflict with privacy-focused messaging

The onboarding should feel safe, practical, and operational rather than surveillance-oriented.

---

# Final Onboarding Structure

## Page 1 — What It Does

### Goal

Explain AI-powered traffic counting.

### Key Concepts

- camera input
- pedestrian detection
- vehicle detection
- occupancy measurement
- local AI processing

---

## Page 2 — Privacy

### Goal

Reduce surveillance concerns immediately.

### Key Concepts

- no video upload
- no images uploaded
- no identities stored
- anonymous aggregated summaries
- privacy-first architecture

---

## Page 3 — Automation

### Goal

Explain operational simplicity.

### Key Concepts

- autonomous operation
- continuous monitoring
- local storage
- hourly uploads
- cloud or self-hosted backend

---

# Final Notes

The onboarding intentionally prioritizes:

- clarity over completeness
- trust over technical depth
- simplicity over feature density

A successful onboarding flow should leave users with a quick and accurate understanding of the product without overwhelming them with implementation details.

The ideal user reaction after viewing the 3 pages is:

> "This is an automated, privacy-safe AI traffic counter that runs by itself."