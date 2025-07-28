#scripts/upgrade_deps.sh
# This script upgrades Dart and Flutter dependencies to their latest versions.
# version: 1.1.0
#!/usr/bin/env bash

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print step headers
print_step() {
    echo -e "\n${BLUE}===================================================${NC}"
    echo -e "${BLUE} STEP: $1${NC}"
    echo -e "${BLUE}===================================================${NC}"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print error messages
print_error() {
    echo -e "${RED}❌ ERROR: $1${NC}" >&2
}

# Function to print warning messages
print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
}

# Function to print info messages
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Error handler
handle_error() {
    local exit_code=$?
    local line_number=$1
    print_error "Script failed at line $line_number with exit code $exit_code"
    print_error "Dependencies upgrade process was interrupted"
    exit $exit_code
}

# Set up error handling
trap 'handle_error $LINENO' ERR

print_step "Setting up environment"

# Get the absolute path to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
print_info "Script directory: $SCRIPT_DIR"

# Get project root (one level up from script)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
print_info "Project root: $PROJECT_ROOT"

# Change directory to project root
print_info "Changing to project directory..."
cd "$PROJECT_ROOT" || {
    print_error "Failed to change to project root directory: $PROJECT_ROOT"
    exit 1
}
print_success "Changed to project directory: $(pwd)"

print_step "Analyzing current dependencies"

# Check if pubspec.yaml exists
if [[ ! -f "pubspec.yaml" ]]; then
    print_error "pubspec.yaml not found in project root"
    exit 1
fi
print_success "Found pubspec.yaml"

# Run the Dart script to update version constraints
print_info "Running dependency analysis script..."
if dart run scripts/upgrade_deps.dart; then
    print_success "Dependency analysis completed successfully"
else
    print_error "Failed to analyze dependencies"
    exit 1
fi

print_step "Upgrading Flutter dependencies"

# Upgrade dependencies
print_info "Running 'flutter pub upgrade --major-versions'..."
print_warning "This may take a few minutes depending on your project size..."
if flutter pub upgrade --major-versions; then
    print_success "Dependencies upgraded successfully"
    print_info "All Flutter dependencies have been updated to their latest compatible versions"
else
    print_error "Failed to upgrade dependencies"
    print_warning "This could be due to version conflicts or network issues"
    exit 1
fi

print_step "Running tests to verify upgrade"

# Run tests to ensure everything is working after the upgrade
print_info "Running tests to ensure compatibility..."
print_warning "This step is crucial to verify that the upgraded dependencies work correctly"
if flutter test; then
    print_success "All tests passed - dependency upgrade is compatible"
else
    print_error "Some tests failed after dependency upgrade"
    print_warning "Please review test failures and fix any compatibility issues"
    print_info "Common issues include:"
    print_info "  • Breaking changes in upgraded packages"
    print_info "  • API changes requiring code updates"
    print_info "  • Version conflicts between dependencies"
    exit 1
fi

print_step "Updating pod repositories"

# Update macOS pod repository
print_info "Updating macOS pod repository..."
if cd macos && pod repo update; then
    print_success "macOS pod repository updated successfully"
    cd ..
else
    print_error "Failed to update macOS pod repository"
    cd .. 2>/dev/null || true  # Ensure we return to project root even if cd fails
    exit 1
fi

# Update iOS pod repository
print_info "Updating iOS pod repository..."
if cd ios && pod repo update; then
    print_success "iOS pod repository updated successfully"
    cd ..
else
    print_error "Failed to update iOS pod repository"
    cd .. 2>/dev/null || true  # Ensure we return to project root even if cd fails
    exit 1
fi

print_step "Upgrade completed successfully!"


print_success "🎉 All dependencies have been upgraded successfully!"
print_info "Summary of completed steps:"
print_info "  ✓ Analyzed current dependencies"
print_info "  ✓ Updated version constraints in pubspec.yaml"
print_info "  ✓ Upgraded all dependencies to latest versions"
print_info "  ✓ Verified compatibility with tests"
print_info "  ✓ Updated macOS pod repository"
print_info "  ✓ Updated iOS pod repository"
echo -e "\n${GREEN}Your project is now using the latest compatible dependency versions.${NC}"
print_info "Next steps:"
print_info "  • Review any warnings from the upgrade process"
print_info "  • Test your app thoroughly on all target platforms"
print_info "  • Check for any deprecated API usage"
print_info "  • Update your CI/CD pipelines if needed"
