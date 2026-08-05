# release/release_windows.sh
# This script builds the Flutter windows application and prepares it for release.
#!/bin/bash
set -e  # Exit immediately on error
echo "Loading environment..."
set -a && source .env && set +a

echo "Building Flutter windows release..."

# . Package into MSIX installer
dart run msix:create

msstore publish build/windows/x64/runner/Release/counter_app.msix -id 9NZ6VCXRJJZD

msstore submission updateMetadata 9NZ6VCXRJJZD "$(< metadata.json)"

msstore submission publish 9NZ6VCXRJJZD