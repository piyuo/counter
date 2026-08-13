# release/release_ios.sh

#!/bin/bash
set -e

echo "Loading environment..."
set -a && source ../../.env && set +a

echo "Building Flutter ios release..."
flutter build ios --release

echo "Running Fastlane release..."
cd ios/fastlane
bundle exec fastlane ios release
cd ../..

echo "Uploading iOS debug symbols to Sentry..."

find build/ios/Counter.xcarchive/dSYMs \
  -name "*.dSYM" \
  -print0 |
xargs -0 sentry-cli debug-files upload \
  --org "$SENTRY_ORG" \
  --project "$SENTRY_PROJECT" \
  --type dsym \
  --wait

echo "iOS debug symbols uploaded successfully."

rm -rf build/ios
rm -f ios/Counter.ipa
rm -f ios/Counter.app.dSYM.zip
rm -f ios/Counter.pkg