# Release Guide

This guide releases Piyuo Counter to Google Play, the iOS App Store, and the
macOS App Store. The release scripts build each platform and upload it through
Fastlane.

## Before You Start

- Merge the Release Please pull request into `main`. This updates the app
  version in `pubspec.yaml` and the application changelog.
- Create a release issue and branch. For example:

  ```sh
  ./scripts/start_issue.sh <issue-number>
  ```

- Confirm `apps/counter_app/pubspec.yaml` contains the version you intend to
  release.
- Commit any intended changes to `apps/counter_app/.build_number` (managed by
  Fastlane) and confirm it exists. This file tracks the build number across all
  platforms and is incremented during the release process.
- Install the required local tooling: Flutter, Xcode and its command-line
  tools, Ruby and Bundler.
- Ensure `apps/counter_app/.env` is present and contains the values required by
  the iOS, macOS, and Android Fastlane lanes.
- Ensure the App Store Connect and Google Play credentials used by Fastlane are
  available locally. Do not commit credentials or `.env` files.

## Prepare Store Metadata

1. Review the current app changelog and write concise release notes for every
   supported locale in `release/release_notes/`.
2. Update localized descriptions, keywords, and subtitles as needed in:

   - `release/description/`
   - `release/keywords/`
   - `release/subtitle/`

   The prompt files `build_release_notes.md`, `build_description.md`,
   `build_keywords.md`, and `build_subtitle.md` define the expected translation
   format.
3. Copy the localized metadata into each Fastlane metadata directory:

   ```sh
   cd apps/counter_app
   ./release/build_fastlane_metadata.sh
   ```

4. Review the generated metadata under `ios/fastlane/metadata/`,
   `macos/fastlane/metadata/`, and `android/fastlane/metadata/android/` before
   uploading it.

## Validate Locally

From `apps/counter_app`, refresh dependencies and run the test suite:

```sh
flutter pub get
flutter test
```

Resolve any test, analysis, signing, or metadata errors before starting the
store upload. Confirm the working tree contains only intended release changes.

## Release All Platforms

From `apps/counter_app`, run:

```sh
./release/release.sh
```

The script releases platforms in this order:

1. Android: builds an app bundle, removes Google Play locales that are not
   accepted, then runs the Android Fastlane release lane.
2. iOS: builds the Flutter iOS release, then runs the iOS Fastlane release
   lane.
3. macOS: builds the Flutter macOS release, then runs the macOS Fastlane
   release lane.

During each release, Fastlane reads the current build number from
`apps/counter_app/.build_number`, increments it, and stores the new value
back to the file. This incremented build number is applied to all platforms
and submitted to the app stores. Commit the updated `.build_number` file when
finishing the release branch.

The script exits immediately after a platform fails. Earlier successful uploads
are not rolled back automatically; inspect the relevant store console and rerun
the required platform release only after correcting the failure.

## Verify the Release

1. Confirm the expected version and build are processing in Google Play Console
   and App Store Connect.
2. Review localized metadata, release notes, screenshots, distribution tracks,
   pricing, and availability in each console.
3. Complete platform-specific review, testing, or staged-rollout actions.
4. Confirm the released build installs and starts correctly on each target
   platform.

## Finish the Release Branch

Commit the updated `.build_number` file and any other release metadata changes.
Create a pull request back to `main` with this title format:

```text
chore(store): release <version>
```

Example: `chore(store): release 1.2.0`

Include the updated `.build_number` in your commit so the build number
progression is tracked in version control across all platforms.
