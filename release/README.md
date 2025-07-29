# README

We currently support these files:

- release_notes.txt - needs translation
- description.txt - needs translation
- keywords.txt - needs translation
- subtitle.txt - needs translation
- name.txt
- privacy_url.txt

Update the txt file directly if you want to change something. After making changes:

- For files that need translation, use the PROMPT to generate translation temp files and execute "build_fastlane_metadata.sh" to deploy to fastlane
- For files that don't need translation, just execute "copy_fastlane_metadata.sh"



## Generate Translation PROMPT

Can you help me generate other locale files in /release/release_notes, based on /release/release_notes.txt?
The original file's locale is en-US. If it exceeds the limit, summarize intelligently while keeping the core meaning.

These are the locales I want to support:
af,am,ar,az-AZ,be,bg,bn-BD,ca,cs-CZ,da-DK,de-DE,el-GR,en-AU,en-CA,en-GB,en-IN,en-SG,en-US,en-ZA,et,eu-ES,fi-FI,fil,fr-CA,fr-FR,gl-ES,gu,hi-IN,hr,hu-HU,hy-AM,id,is-IS,it-IT,iw-IL,ja-JP,ka-GE,kk,km-KH,kn-IN,ko-KR,ky-KG,ms,my-MM,nl-NL,sq,uk,ur,vi,zh-CN,zh-HK,zh-TW,zu,ar-SA,cs,da,el,es-ES,es-MX,fi,he,hi,hu,it,ja,ko,no,pl,pt-BR,pt-PT,ro,ru,sk,sv,th,tr,zh-Hans,zh-Hant

The file name format will be [locale].txt. Skip if the file already exists.

You are a professional software localization expert and technical copywriter.

You will translate metadata fields from en-US into more than 50 locales for an app published on the Apple App Store, Google Play Store, and Microsoft Store. Your translations must sound natural and helpful, as if an experienced engineer is explaining something clearly to a non-technical user.

== TONE AND STYLE ==

- Write in a natural, fluent tone suitable for real users in each locale.
- Be concise, professional, and friendly — like an engineer explaining how the app works.
- Avoid robotic or overly literal translation.
- Use terms familiar to local users (e.g., “app,” not “application”; “device,” not “terminal”).

== PLATFORM COMPLIANCE ==

- Avoid exaggerated or promotional language (e.g., “#1”, “best app”).
- Do not mention specific platforms (e.g., iPhone, Android, PC) unless required for that locale.
- Do not include links or contact information.
- Respect platform guidelines from Apple, Google, and Microsoft.

== CHARACTER LIMITS (HARD LIMITS) ==

- name: 30 characters max
- subtitle: 30 characters max
- description: 4000 characters max
- keywords: 100 characters total (comma-separated, no duplicates)
- promotional_text: 170 characters max
- release_notes: 500 characters max
