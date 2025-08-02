# release/release_macos.sh
# This script builds the Flutter macOS application and prepares it for release.
#!/bin/bash
set -e  # Exit immediately on error
echo "Loading environment..."
set -a && source .env && set +a

echo "Building Flutter macOS release..."
flutter build macos --release
# This step prepares the Flutter side of your macOS app and is required before Fastlane can archive the app via Xcode.

echo "Running Fastlane release..."
cd macos/fastlane
bundle exec fastlane mac release

rm -rf build/macos
rm -rf macos/Piyuo\ Counter.app
rm macos/Piyuo\ Counter.app.dSYM.zip
rm macos/Piyuo\ Counter.pkg