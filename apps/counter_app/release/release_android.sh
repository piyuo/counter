# release/release_android.sh
# This script builds the Flutter android application and prepares it for release.
#!/bin/bash
set -e  # Exit immediately on error
echo "Loading environment..."
set -a && source ../../.env && set +a

echo "Building Flutter android release..."
flutter build appbundle --release --target-platform android-arm64
# This step prepares the Flutter side of your android app and is required.


#cleanup android locales
echo "Cleaning up Android locales..."
release/cleanup_android_locales.sh

# Publish with fastlane
echo "Running Fastlane release..."
cd android/fastlane
bundle exec fastlane android release
cd ../..

# Upload debug symbols to Sentry
echo "Uploading Android native debug information to Sentry..."
sentry-cli debug-files upload \
  --org "$SENTRY_ORG" \
  --project "$SENTRY_PROJECT" \
  --type elf \
  --wait \
  build/app/intermediates/native_symbol_tables/release/extractReleaseNativeSymbolTables/out/arm64-v8a

echo "Uploading Android ProGuard mapping to Sentry..."
sentry-cli upload-proguard \
  --org "$SENTRY_ORG" \
  --project "$SENTRY_PROJECT" \
  build/app/outputs/mapping/release/mapping.txt

rm -rf build/app
