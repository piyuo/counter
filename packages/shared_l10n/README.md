# shared_l10n

## Table of Contents

- Overview
- Source of Truth
- File Layout
- How Localization Works
- Add a New Translation
- Update an Existing Translation
- Key Naming Convention
- Use Localization in Code
- CSV Rules
- Generate Files
- Notes

## Overview

`shared_l10n` is the central localization package for this workspace.

All app strings are defined in a single CSV file:

- `packages/shared_l10n/lib/l10n.csv`

Other packages should not define their own translation files. They should use `shared_l10n` and access strings through `context.l`.

## Source of Truth

The source of truth is:

- `packages/shared_l10n/lib/l10n.csv`

Do not edit generated ARB files or generated localization Dart files by hand. They will be overwritten the next time generation runs.

## File Layout

```text
packages/shared_l10n/
├── lib/
│   ├── generated/
│   │   ├── app_en.arb
│   │   ├── app_*.arb
│   │   └── localization.dart
│   ├── util/
│   │   └── extension.dart
│   ├── l10n.csv
│   └── shared_l10n.dart
├── l10n.yaml
└── README.md
```

## How Localization Works

1. Add or update keys in `lib/l10n.csv`.
2. Run `scripts/build_translation.sh` from the repository root.
3. The script converts the CSV into ARB files in `lib/generated/`.
4. `flutter gen-l10n` then generates `lib/generated/localization.dart`.
5. App code uses the generated API through `context.l`.

## Add a New Translation

When you need a new localized string:

1. Add a new row to `packages/shared_l10n/lib/l10n.csv`.
2. Use a stable key name such as `about_screen_email_us` or `video_sources_webcam`.
3. Fill in translations for every locale column.
4. Keep wording simple, natural, and easy to understand.
5. Run the generation script.
6. Use the key in code through `context.l.your_key_name`.

Example CSV row:

```csv
about_screen_email_us,Email us,راسلنا عبر البريد الإلكتروني,আমাদের ইমেইল করুন,...
```

## Update an Existing Translation

When copy changes after a product refactor:

1. Find the existing key in `packages/shared_l10n/lib/l10n.csv`.
2. Update the wording across locales.
3. Keep the key name if the meaning is still the same.
4. Rename the key only when the meaning has changed.
5. Regenerate localization files.

This keeps code references stable and avoids unnecessary churn.

## Key Naming Convention

The preferred naming pattern is:

```text
{screen}_{element}_{type}
```

This convention works well because:

- Keys group naturally by screen in editors and code search.
- Names stay readable and self-explanatory.
- The pattern scales cleanly as the app grows.

Examples:

```text
about_screen_app_version_label
detection_screen_reset_title
detection_screen_reset_body
detection_screen_title
url_screen_url_hint
```

### Recommended suffixes

Use consistent suffixes for common UI text types:

- `_title` for screen titles and dialog titles
- `_body` for longer descriptive text or dialog body text
- `_label` for short labels and item names
- `_hint` for input placeholders
- `_action` for button text and action labels
- `_error` for error messages

### Global keys

For truly global strings, do not add a screen prefix.

Examples:

```text
yes
no
submit
```

### Consistency rules

- Prefer one suffix for one meaning.
- Avoid mixing `_content` and `_desc` when both mean body text.
- Prefer `_body` for longer explanatory text when the string is not specifically a title or label.
- Prefer `_hint` instead of `_placeholder` for input guidance.
- Add `_label` when a short piece of text could otherwise be confused with a title, body, or action.

### Existing patterns in this project

This project already uses some good patterns such as `_title` and `_desc`.

When adding new keys:

- keep existing names if renaming would create unnecessary churn
- prefer the refined convention for new work
- only rename old keys when you are already touching the affected code and the meaning is clearer after the rename

Examples of refinement:

```text
detection_screen_reset_content  -> detection_screen_reset_body
url_screen_url_placeholder      -> url_screen_url_hint
about_screen_app_version        -> about_screen_app_version_label
```

## Use Localization in Code

Import the package:

```dart
import 'package:shared_l10n/shared_l10n.dart';
```

Then use translations from `BuildContext`:

```dart
Text(context.l.about_screen_platform)
```

The `context.l` helper comes from:

- `lib/util/extension.dart`

And is re-exported by:

- `lib/shared_l10n.dart`

## CSV Rules

The first column must be `Key`.

Each remaining column is a locale in the form `app_<locale>`.

Example header:

```csv
Key,app_ar,app_bn,app_de,app_el,app_en,app_es
```

Rules:

- One row = one localization key.
- Keep keys lowercase with underscores.
- Keep labels short when they are used in buttons, menus, and dialogs.
- Use clear product wording instead of literal or overly technical wording.
- If a value contains a comma, wrap it in double quotes.
- If a value contains a double quote, escape it as `""` inside CSV.

Examples:

```csv
simple_label,Save,حفظ,সংরক্ষণ,...
message_with_comma,"Hello, welcome back",..., ...
quoted_text,"She said ""Hello""",..., ...
```

## Generate Files

Run this from the repository root:

```bash
scripts/build_translation.sh
```

What this does:

1. Reads `packages/shared_l10n/lib/l10n.csv`
2. Writes ARB files to `packages/shared_l10n/lib/generated/`
3. Runs `flutter gen-l10n` using `packages/shared_l10n/l10n.yaml`
4. Updates generated localization Dart files

## Notes

- Generated files should not be edited manually.
- If code reports missing getters like `context.l.some_key`, first check whether the key exists in `l10n.csv`.
- After removing old keys during cleanup, scan the codebase for remaining usages before regenerating.
- Prefer improving existing translations over adding duplicate keys with slightly different wording.
