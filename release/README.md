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

generate other locale files in `/release/release_notes` based on `/release/release_notes.txt` (original locale: en-US). If the translation exceeds the character limit, summarize while keeping the core meaning.

for example , generate `/release/release_notes/zh-TW.txt` with proper translation from `/release/release_notes.txt`
all translation must meet local custom and easy understand by user, and don't sound like computer generated.
please make sure all files in `/release/release_notes` are properly translated. don't miss any file.
and all files in `/release/release_notes` should be updated, cause their content might be from last version release notes,
which we don't need anymore, so just replace their content to new translation.


Locales to support:
af, am, ar, az-AZ, be, bg, bn-BD, ca, cs-CZ, da-DK, de-DE, el-GR, en-AU, en-CA, en-GB, en-IN, en-SG, en-US, en-ZA, et, eu-ES, fi-FI, fil, fr-CA, fr-FR, gl-ES, gu, hi-IN, hr, hu-HU, hy-AM, id, is-IS, it-IT, iw-IL, ja-JP, ka-GE, kk, km-KH, kn-IN, ko-KR, ky-KG, ms, my-MM, nl-NL, sq, uk, ur, vi, zh-CN, zh-HK, zh-TW, zu, ar-SA, cs, da, el, es-ES, es-MX, fi, he, hi, hu, it, ja, ko, no, pl, pt-BR, pt-PT, ro, ru, sk, sv, th, tr, zh-Hans, zh-Hant

File name format: `[locale].txt`. Skip if the file already exists.

**Translation Guidelines:**

- Write in a natural, fluent tone for each locale.
- Be concise, professional, and friendly—like an engineer explaining the app.
- Avoid robotic or overly literal translation.
- Use terms familiar to local users (e.g., “app,” not “application”).
- Avoid exaggerated or promotional language (e.g., “#1”, “best app”).
- Do not mention specific platforms unless required for that locale.
- Do not include links or contact information.
- Respect Apple, Google, and Microsoft platform guidelines.

**Character Limits:**

- name: 30 characters max
- subtitle: 30 characters max
- description: 4000 characters max
- keywords: 100 characters total (comma-separated, no duplicates)
- promotional_text: 170 characters max
- release_notes: 500 characters max
