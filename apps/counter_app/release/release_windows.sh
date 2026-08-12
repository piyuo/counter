# release/release_windows.sh
# This script builds the Flutter windows application and prepares it for release.
#!/bin/bash
set -e  # Exit immediately on error
echo "Loading environment..."
set -a && source ../../.env && set +a

echo "Building Flutter Windows release..."
flutter build windows --release

echo "Uploading Windows debug symbols to Sentry..."
sentry-cli debug-files upload \
  --org "$SENTRY_ORG" \
  --project "$SENTRY_PROJECT" \
  --type pdb \
  --wait \
  build/windows/x64/runner/Release/counter.pdb \
  build/windows/x64/plugins/flutter_vision/Release/flutter_vision_plugin.pdb

echo "Removing debug symbols from MSIX package..."
rm -f build/windows/x64/runner/Release/counter.pdb

echo "Building MSIX..."
dart run msix:create --build-windows false

# submit package and create a new submission and publish. this command pretty much does everything for you, but you may still need
msstore publish build/windows/x64/runner/Release/counter_app.msix -id 9NZ6VCXRJJZD

#msstore submission updateMetadata 9NZ6VCXRJJZD "$(< metadata.json)"

#msstore submission publish 9NZ6VCXRJJZD