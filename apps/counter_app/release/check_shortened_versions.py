#!/usr/bin/env python3

# Shortened versions under 500 characters
shortened_versions = {
    'en-AU': 'Bug Fixes\\n\\n- Fixed a crash when closing a project after 30 seconds.\\n- Resolved upside-down image issue with front camera on some devices.\\n- Corrected several incorrect language translations.\\n- Fixed app freezing when camera permissions were denied.',

    'en-CA': 'Bug Fixes\\n\\n- Fixed a crash when closing a project after 30 seconds.\\n- Resolved upside-down image issue with front camera on some devices.\\n- Corrected several incorrect language translations.\\n- Fixed app freezing when camera permissions were denied.',

    'en-GB': 'Bug Fixes\\n\\n- Fixed a crash when closing a project after 30 seconds.\\n- Resolved upside-down image issue with front camera on some devices.\\n- Corrected several incorrect language translations.\\n- Fixed app freezing when camera permissions were denied.',

    'en-IN': 'Bug Fixes\\n\\n- Fixed a crash when closing a project after 30 seconds.\\n- Resolved upside-down image issue with front camera on some devices.\\n- Corrected several incorrect language translations.\\n- Fixed app freezing when camera permissions were denied.',

    'en-SG': 'Bug Fixes\\n\\n- Fixed a crash when closing a project after 30 seconds.\\n- Resolved upside-down image issue with front camera on some devices.\\n- Corrected several incorrect language translations.\\n- Fixed app freezing when camera permissions were denied.',

    'en-US': 'Bug Fixes\\n\\n- Fixed a crash when closing a project after 30 seconds.\\n- Resolved upside-down image issue with front camera on some devices.\\n- Corrected several incorrect language translations.\\n- Fixed app freezing when camera permissions were denied.',

    'en-ZA': 'Bug Fixes\\n\\n- Fixed a crash when closing a project after 30 seconds.\\n- Resolved upside-down image issue with front camera on some devices.\\n- Corrected several incorrect language translations.\\n- Fixed app freezing when camera permissions were denied.'
}

# Check lengths
for lang, text in shortened_versions.items():
    # Convert \\n to actual newlines for length calculation
    actual_text = text.replace('\\n', '\n')
    print(f"{lang}: {len(actual_text)} characters")

print("\nShortest version length:", min(len(text.replace('\\n', '\n')) for text in shortened_versions.values()))
print("All versions are identical and should be under 500 characters.")
