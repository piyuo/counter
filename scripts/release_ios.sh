set -a && source .env && set +a
flutter build ios --release
# after run this script, goto ios/Runner.xcworkspace and run the following command Project > Archive,
