# Get the absolute path to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get project root (one level up from script)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Change directory to project root
cd "$PROJECT_ROOT" || exit 1

# Run the Dart script (relative to project root)
dart run scripts/upgrade_deps.dart

# Upgrade dependencies
flutter pub upgrade --major-versions