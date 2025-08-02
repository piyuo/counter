# release/release_android.sh
# This script builds the Flutter android application and prepares it for release.
#!/bin/bash
set -e  # Exit immediately on error
echo "Loading environment..."
set -a && source .env && set +a

echo "Building Flutter android release..."
flutter build appbundle --release
# This step prepares the Flutter side of your android app and is required.

echo "Running Fastlane release..."
cd android/fastlane
bundle exec fastlane android release

rm -rf build/app
