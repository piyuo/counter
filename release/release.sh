#!/bin/bash
# release/release.sh
# Master release script that builds and releases for all platforms (Android, iOS, macOS)
# This script will abort if any platform release fails

set -e  # Exit immediately on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored status messages
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to run a release script and handle errors
run_release() {
    local platform=$1
    local script_path=$2

    print_status "Starting $platform release..."

    if [ ! -f "$script_path" ]; then
        print_error "$platform release script not found: $script_path"
        exit 1
    fi

    if ! chmod +x "$script_path"; then
        print_error "Failed to make $script_path executable"
        exit 1
    fi

    if ! "$script_path"; then
        print_error "$platform release failed!"
        print_error "Check the output above for error details."
        exit 1
    fi

    print_success "$platform release completed successfully!"
}

# Main execution
echo "=================================================="
print_status "Starting multi-platform release process"
print_status "Platforms: Android, iOS, macOS"
echo "=================================================="

# Check if we're in the correct directory (should have pubspec.yaml)
if [ ! -f "pubspec.yaml" ]; then
    print_error "This script must be run from the Flutter project root directory"
    print_error "Make sure you're in the directory containing pubspec.yaml"
    exit 1
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    print_warning ".env file not found - some release scripts may fail"
fi

# Record start time
start_time=$(date +%s)

# Release Android
run_release "Android" "release/release_android.sh"

# Release iOS
run_release "iOS" "release/release_ios.sh"

# Release macOS
run_release "macOS" "release/release_macos.sh"

# Calculate and display total time
end_time=$(date +%s)
total_time=$((end_time - start_time))
minutes=$((total_time / 60))
seconds=$((total_time % 60))

echo "=================================================="
print_success "All platform releases completed successfully!"
print_status "Total time: ${minutes}m ${seconds}s"
echo "=================================================="

print_status "Release summary:"
print_success "✓ Android release completed"
print_success "✓ iOS release completed"
print_success "✓ macOS release completed"
echo ""
print_status "All apps have been built and released to their respective app stores."
