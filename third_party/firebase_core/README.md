# VENDORED COPY — Windows platform stripped

This is a local copy of [`firebase_core` 4.14.0](https://pub.dev/packages/firebase_core)
used via a `dependency_overrides` entry in the repo root `pubspec.yaml`.

## Why

Upstream `firebase_core` declares Windows as a supported plugin platform. Its
`windows/CMakeLists.txt` unconditionally downloads and links the Firebase C++ SDK
during CMake configuration whenever `flutter build windows` (or opening the
`windows/` project in Visual Studio) runs — regardless of whether any Dart code
actually calls Firebase on Windows. That caused link errors building this app for
Windows, even though Firebase Analytics is only ever used on Android/iOS/macOS
(see `apps/counter_app/lib/analytics_initializer.dart`).

This copy only removes the `windows:` entry from `flutter: plugin: platforms:` in
`pubspec.yaml`, and deletes the unused `windows/` and `example/` folders. No other
code is changed. Android, iOS, macOS and web behave identically to upstream.

## Updating

To pick up a newer `firebase_core` release:

1. Locate the new version under `~/.pub-cache/hosted/pub.dev/firebase_core-<version>`.
2. Copy it over this directory (excluding `windows/` and `example/`).
3. Re-apply the `windows:` removal from `pubspec.yaml`'s `flutter.plugin.platforms`
   and remove `resolution: workspace` (this copy is not a workspace member).
4. Update the `firebase_core` version pin in `pubspec.yaml`'s `dependency_overrides`
   comment (if any) and re-run `dart pub get` at the repo root.

---

[![pub package](https://img.shields.io/pub/v/firebase_core.svg)](https://pub.dev/packages/firebase_core)

A Flutter plugin to use the Firebase Core API, which enables connecting to multiple Firebase apps.

To learn more about Firebase, please visit the [Firebase website](https://firebase.google.com)

## Getting Started

To get started with FlutterFire, please [see the documentation](https://firebase.google.com/docs/flutter/setup?platform=ios).

## Usage

To use this plugin, please visit the [Core Usage documentation](https://firebase.google.com/docs/flutter/setup)

## Issues and feedback

Please file FlutterFire specific issues, bugs, or feature requests in our [issue tracker](https://github.com/firebase/flutterfire/issues/new).

Plugin issues that are not specific to FlutterFire can be filed in the [Flutter issue tracker](https://github.com/flutter/flutter/issues/new).

To contribute a change to this plugin,
please review our [contribution guide](https://github.com/firebase/flutterfire/blob/main/CONTRIBUTING.md)
and open a [pull request](https://github.com/firebase/flutterfire/pulls).
