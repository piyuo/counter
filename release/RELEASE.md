<!-- release/README.md -->
# RELEASE GUIDE

This document explains how to release the app to the public. Before starting, ensure the release-please branch has been merged into the main branch, so the latest version number and CHANGELOG.md are up to date.

## Release Steps (Local Machine)

1. Switch to the `main` branch and pull the latest changes:

   ```sh
   git checkout main
   git pull
   ```

2. Review `CHANGELOG.md` for the latest version number and changes.
3. Create a release branch for the new version (e.g., `release-app-1.1.0`). This is needed because some files will be changed during the release process. After release, you can merge this branch back to `main`.
4. Summarize the latest version changes from `CHANGELOG.md` and write result to `release/release_notes.txt`. Ensure the result content is user-friendly and does not exceed 500 characters.
5. Use the "Generate Translation PROMPT" section below to generate translations for all supported languages.
6. Ask current user to Confirm everything is ready: double-check that the build process succeeds, release notes are correct, and any other fields you want to update have been changed.

7. Run the release script:

   ```sh
   ./release/release.sh
   ```

   This will execute `release_ios.sh`, `release_macos.sh`, and `release_android.sh` to build and upload the app using Fastlane.
8. If `release.sh` succeeds, create a pull request to merge the release branch back to `main`. Use the following PR title format:

   ```sh
   chore(store): release [version]
   ```

   Example: `chore(store): release 2.1.2`

## Editable Metadata Fields

Some metadata fields (description, keywords, etc.) are not changed often. If you need to update them, edit the relevant text file and run the appropriate script. These changes will be included in the next release.

Supported files:

- `release_notes.txt` (needs translation)
- `description.txt` (needs translation)
- `keywords.txt` (needs translation)
- `subtitle.txt` (needs translation)
- `name.txt`
- `privacy_url.txt`

After editing:

- For files that need translation, use the PROMPT below to generate translation files, then run `build_fastlane_metadata.sh` to deploy to Fastlane.
- For files that do not need translation, run `copy_fastlane_metadata.sh`.

## Generate Translation PROMPT

**Task:** Generate a localized `release_notes.csv` file from a source text file.

**Goal:** Create a CSV file that serves as a localization resource, containing translations of release notes for all supported locales.

**Input:**

- Source text: The release notes are located in `/release/release_notes.txt`.
- Supported locales: A comprehensive list of locales to be included in the output CSV.

**Locales to Support:**
af, am, ar, az-AZ, be, bg, bn-BD, ca, cs-CZ, da-DK, de-DE, el-GR, en-AU, en-CA, en-GB, en-IN, en-SG, en-US, en-ZA, et, eu-ES, fi-FI, fil, fr-CA, fr-FR, gl-ES, gu, hi-IN, hr, hu-HU, hy-AM, id, is-IS, it-IT, iw-IL, ja-JP, ka-GE, kk, km-KH, kn-IN, ko-KR, ky-KG, ms, my-MM, nl-NL, sq, uk, ur, vi, zh-CN, zh-HK, zh-TW, zu, ar-SA, cs, da, el, es-ES, es-MX, fi, he, hi, hu, it, ja, ko, no, pl, pt-BR, pt-PT, ro, ru, sk, sv, th, tr, zh-Hans, zh-Hant

**Output File:**

- `release_notes.csv`
- The file should be saved in the root directory.
- If the file already exists, it must be replaced with the new content.

**CSV Formatting Guidelines:**

- **Header:** The first row must be the header, starting with `"key"` followed by all supported locale codes.
  - *Example:* `"key","zh-Hans","zh-Hant","en-US",...`
- **Data Rows:** Each subsequent row will contain a key and its translations.
- **Quoting:** All fields in the CSV must be enclosed in double quotes (`"`).
- **Escaping:** The newline character `\n` must be escaped within the CSV field.
  - *Example:* `"Fixed a bug.\nAdded a new feature."`
- **Keys:** The key for the release notes should be `notes`.
  - *Example:* `notes,"更改 1","更改 2",...`

**Translation Guidelines:**

- **Tone:** Translations should be natural, fluent, and easy for local users to understand. The tone should be professional and friendly, as if from an engineer.
- **Readability:** Avoid overly literal or robotic-sounding translations. Use terms familiar to local users (e.g., "app" instead of "application").
- **Exclusions:**
  - Do not use exaggerated or promotional language (e.g., "#1 app," "best app ever").
  - Do not include links, URLs, or contact information.
  - Do not mention specific platforms (e.g., Apple, Google) unless explicitly required for that locale's context.
- **Constraints:**
  - Adhere to the `500` character limit for the `release_notes` string in all translations.
  - Ensure all files in `/release/release_notes/` are translated and included. Do not miss any files.
