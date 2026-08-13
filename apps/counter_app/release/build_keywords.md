# Task

Read the source file:

`apps/counter_app/release/build_keywords.txt`

This file is the English (`en-US`) source.

Keep the original `build_keywords.txt` unchanged.

Create translated UTF-8 `.txt` files in:

`apps/counter_app/release/keywords/`

First, copy the English source to:

`apps/counter_app/release/keywords/en-US.txt`

Then create one translated file for every locale listed below, using the locale identifier **exactly** as written.

## Locales

```
en-US, en-AU, en-CA, en-GB
zh-TW, zh-CN
ja-JP
ko-KR
de-DE
fr-FR, fr-CA
es-ES, es-MX
it-IT
pt-BR, pt-PT
ru-RU
tr-TR
th
vi
id
ms
hi, hi-IN
nl-NL
pl-PL
ro
uk
hu-HU
el-GR
ar
fa
he
sr
bn-BD
my-MM
ca
hr
cs
da
fi
no
sk
sv

```

## Translation Guidelines

- Translate every file directly from `apps/counter_app/release/build_keywords.txt`.
- Preserve the original structure, including:
  - Paragraph breaks
  - Blank lines
  - Bullet lists
  - Numbering
  - Punctuation
  - Emoji (if any)
  - Ordering of content
- Do **not** add, remove, or rearrange information.
- Keep product names and proper nouns unchanged unless they already have an official localized name. In particular, **do not translate**:
  - `Piyuo`
  - `Piyuo Counter`
- Use natural, fluent language that feels native to local users.
- Write in a professional, friendly tone, as if written by an engineer.
- Prefer common words users expect (for example, "app" instead of "application" where appropriate).
- Avoid overly literal or machine-like translations.
- Do **not** use exaggerated or promotional language (for example: "best app", "#1 app", "world's greatest").
- Do **not** add links, URLs, contact information, or platform-specific references unless they already exist in the source text.
- Each translated file must remain within the **500-character** limit. If a direct translation would exceed the limit, shorten it naturally while preserving the original meaning.

## Output Requirements

- Create exactly **one UTF-8 encoded `.txt` file** for every locale listed above.
- Use the locale codes **exactly** as listed. Do **not** rename, normalize, or expand locale identifiers (for example, do not change `th` to `th-TH`).
- Save every translated file in:

  `apps/counter_app/release/keywords/`

- The final directory should contain:

  - `en-US.txt` (copied from the source)
  - One translated `.txt` file for every remaining locale

## Validation Checklist

Before finishing, verify that:

- ✓ The original `apps/counter_app/release/build_keywords.txt` was **not** modified.
- ✓ `en-US.txt` is an exact copy of the source file.
- ✓ Every locale listed above has exactly one corresponding `.txt` file.
- ✓ No locale is missing.
- ✓ No extra locale files were created.
- ✓ All files are UTF-8 encoded.
- ✓ Every translated file satisfies the 500-character limit.
- ✓ Product names (`Piyuo`, `Piyuo Counter`) remain unchanged.