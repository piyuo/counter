# release/release_ios.sh
# This script builds the Flutter ios application and prepares it for release.
#!/bin/bash
set -e  # Exit immediately on error
echo "Loading environment..."
set -a && source .env && set +a

echo "Building Flutter ios release..."
flutter build ios --release
# This step prepares the Flutter side of your ios app and is required before Fastlane can archive the app via Xcode.

echo "Running Fastlane release..."
cd ios/fastlane
bundle exec fastlane ios release
cd ../..
rm -rf build/ios
rm -f ios/Counter.ipa
rm -f ios/Counter.app.dSYM.zip
rm -f ios/Counter.pkg