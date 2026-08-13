# release/release_macos.sh
# This script builds the Flutter macOS application and prepares it for release.
#!/bin/bash
set -e  # Exit immediately on error
echo "Loading environment..."
set -a && source ../../.env && set +a

echo "Building Flutter macOS release..."
flutter build macos --release

echo "Running Fastlane release..."
cd macos/fastlane
bundle exec fastlane mac release
cd ../..

# Upload debug symbols to Sentry
echo "Uploading information to Sentry..."
find "build/macos/Counter.xcarchive/dSYMs" \
  -name "*.dSYM" \
  -print0 |
xargs -0 sentry-cli debug-files upload \
  --org "$SENTRY_ORG" \
  --project "$SENTRY_PROJECT" \
  --type dsym \
  --wait

echo "macOS debug symbols uploaded successfully."

rm -rf build/macos
rm -rf macos/Piyuo\ Counter.app
rm -f macos/Piyuo\ Counter.app.dSYM.zip
rm -f macos/Piyuo\ Counter.pkg