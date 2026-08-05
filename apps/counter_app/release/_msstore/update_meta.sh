# release/release_windows.sh
# This script builds the Flutter windows application and prepares it for release.
#!/bin/bash
msstore submission updateMetadata 9NZ6VCXRJJZD "$(< meta.json)"
