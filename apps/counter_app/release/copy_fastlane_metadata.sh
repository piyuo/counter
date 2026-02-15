#!/bin/bash

# copy_fastlane_metadata.sh
# Script to copy name.txt and privacy_url.txt to fastlane metadata directories
# Author: Generated script for Counter app
# Usage: ./copy_fastlane_metadata.sh

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Base directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
RELEASE_DIR="$SCRIPT_DIR"
IOS_METADATA_DIR="$PROJECT_ROOT/ios/fastlane/metadata"
MACOS_METADATA_DIR="$PROJECT_ROOT/macos/fastlane/metadata"
ANDROID_METADATA_DIR="$PROJECT_ROOT/android/fastlane/metadata/android"

# Source files
NAME_FILE="$RELEASE_DIR/name.txt"
PRIVACY_URL_FILE="$RELEASE_DIR/privacy_url.txt"

# Counters
total_locales=0
success_count=0
error_count=0

echo -e "${BLUE}=== Fastlane Metadata Copier ===${NC}"
echo -e "${BLUE}Copying name.txt and privacy_url.txt to fastlane metadata directories${NC}"
echo ""

# Function to check if required files and directories exist
check_dependencies() {
    local missing_items=()

    # Check source files
    if [ ! -f "$NAME_FILE" ]; then
        missing_items+=("$NAME_FILE")
    fi

    if [ ! -f "$PRIVACY_URL_FILE" ]; then
        missing_items+=("$PRIVACY_URL_FILE")
    fi

    # Check target base directories
    for dir in "$IOS_METADATA_DIR" "$MACOS_METADATA_DIR" "$ANDROID_METADATA_DIR"; do
        if [ ! -d "$dir" ]; then
            missing_items+=("$dir")
        fi
    done

    if [ ${#missing_items[@]} -gt 0 ]; then
        echo -e "${RED}ERROR: Missing required files or directories:${NC}"
        for item in "${missing_items[@]}"; do
            echo -e "${RED}  - $item${NC}"
        done
        exit 1
    fi
}

# Function to create directory if it doesn't exist
create_dir_if_not_exists() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "${YELLOW}Created directory: $dir${NC}"
    fi
}

# Function to copy file with error handling
copy_file() {
    local src="$1"
    local dest="$2"
    local platform="$3"
    local file_type="$4"

    # Create destination directory if it doesn't exist
    local dest_dir=$(dirname "$dest")
    create_dir_if_not_exists "$dest_dir"

    if cp "$src" "$dest" 2>/dev/null; then
        echo -e "${GREEN}  ✓ $platform: $file_type → $(basename "$dest")${NC}"
        return 0
    else
        echo -e "${RED}  ✗ $platform: Failed to copy $file_type to $(basename "$dest")${NC}"
        return 1
    fi
}

# Function to process a single locale
process_locale() {
    local locale="$1"
    local locale_success=0
    local locale_errors=0

    echo -e "${CYAN}Processing locale: $locale${NC}"

    # Define target directories for this locale
    local ios_locale_dir="$IOS_METADATA_DIR/$locale"
    local macos_locale_dir="$MACOS_METADATA_DIR/$locale"
    local android_locale_dir="$ANDROID_METADATA_DIR/$locale"

    # 1. Process name.txt
    # iOS name
    if copy_file "$NAME_FILE" "$ios_locale_dir/name.txt" "iOS" "name"; then
        ((locale_success++))
    else
        ((locale_errors++))
    fi

    # macOS name
    if copy_file "$NAME_FILE" "$macos_locale_dir/name.txt" "macOS" "name"; then
        ((locale_success++))
    else
        ((locale_errors++))
    fi

    # Android title (name.txt → title.txt)
    if copy_file "$NAME_FILE" "$android_locale_dir/title.txt" "Android" "title"; then
        ((locale_success++))
    else
        ((locale_errors++))
    fi

    # 2. Process privacy_url.txt (iOS and macOS only)
    # iOS privacy_url
    if copy_file "$PRIVACY_URL_FILE" "$ios_locale_dir/privacy_url.txt" "iOS" "privacy_url"; then
        ((locale_success++))
    else
        ((locale_errors++))
    fi

    # macOS privacy_url
    if copy_file "$PRIVACY_URL_FILE" "$macos_locale_dir/privacy_url.txt" "macOS" "privacy_url"; then
        ((locale_success++))
    else
        ((locale_errors++))
    fi

    # Update global counters
    success_count=$((success_count + locale_success))
    error_count=$((error_count + locale_errors))

    echo -e "${BLUE}  Locale $locale: $locale_success successes, $locale_errors errors${NC}"
    echo ""
}

# Function to discover locales from existing fastlane metadata directories
discover_locales() {
    local locales=()

    # Check iOS metadata directory for existing locales
    if [ -d "$IOS_METADATA_DIR" ]; then
        for dir in "$IOS_METADATA_DIR"/*; do
            if [ -d "$dir" ]; then
                locale=$(basename "$dir")
                # Skip common non-locale directories
                if [[ "$locale" != "default" && "$locale" != "review_information" ]]; then
                    if [[ ! " ${locales[@]} " =~ " ${locale} " ]]; then
                        locales+=("$locale")
                    fi
                fi
            fi
        done
    fi

    # Check macOS metadata directory for existing locales
    if [ -d "$MACOS_METADATA_DIR" ]; then
        for dir in "$MACOS_METADATA_DIR"/*; do
            if [ -d "$dir" ]; then
                locale=$(basename "$dir")
                # Skip common non-locale directories
                if [[ "$locale" != "default" && "$locale" != "review_information" ]]; then
                    if [[ ! " ${locales[@]} " =~ " ${locale} " ]]; then
                        locales+=("$locale")
                    fi
                fi
            fi
        done
    fi

    # Check Android metadata directory for existing locales
    if [ -d "$ANDROID_METADATA_DIR" ]; then
        for dir in "$ANDROID_METADATA_DIR"/*; do
            if [ -d "$dir" ]; then
                locale=$(basename "$dir")
                # Skip common non-locale directories
                if [[ "$locale" != "default" && "$locale" != "review_information" ]]; then
                    if [[ ! " ${locales[@]} " =~ " ${locale} " ]]; then
                        locales+=("$locale")
                    fi
                fi
            fi
        done
    fi

    # If no locales found, default to en-US
    if [ ${#locales[@]} -eq 0 ]; then
        locales=("en-US")
        echo -e "${YELLOW}No existing locale directories found, defaulting to en-US${NC}"
    fi

    # Sort locales alphabetically
    IFS=$'\n' locales=($(sort <<<"${locales[*]}"))

    echo "${locales[@]}"
}

# Main execution
echo -e "${BLUE}Checking dependencies...${NC}"
check_dependencies

echo -e "${BLUE}Source files:${NC}"
echo -e "  - Name: $NAME_FILE"
echo -e "  - Privacy URL: $PRIVACY_URL_FILE"
echo ""

echo -e "${BLUE}Target directories:${NC}"
echo -e "  - iOS: $IOS_METADATA_DIR"
echo -e "  - macOS: $MACOS_METADATA_DIR"
echo -e "  - Android: $ANDROID_METADATA_DIR"
echo ""

# Discover existing locales
echo -e "${BLUE}Discovering existing locales...${NC}"
locales=($(discover_locales))
total_locales=${#locales[@]}

echo -e "${BLUE}Found $total_locales locale(s): ${locales[*]}${NC}"
echo ""

# Process each locale
for locale in "${locales[@]}"; do
    process_locale "$locale"
done

# Summary
echo -e "${BLUE}=== Summary ===${NC}"
echo -e "Total locales processed: $total_locales"
echo -e "${GREEN}Total successful operations: $success_count${NC}"

if [ $error_count -gt 0 ]; then
    echo -e "${RED}Total errors: $error_count${NC}"
    echo -e "${YELLOW}Please check the error messages above${NC}"
    exit 1
else
    echo -e "${GREEN}All metadata files copied successfully!${NC}"
    echo -e "${BLUE}Ready for fastlane deployment${NC}"
fi

echo ""
echo -e "${BLUE}File mapping summary:${NC}"
echo -e "  • name.txt → iOS/macOS: name.txt, Android: title.txt"
echo -e "  • privacy_url.txt → iOS/macOS: privacy_url.txt (Android: not used)"

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  - Review the copied metadata files"
echo -e "  - Run fastlane commands for your target platforms"
echo -e "  - iOS: cd ios && fastlane release"
echo -e "  - macOS: cd macos && fastlane release"
echo -e "  - Android: cd android && fastlane release"
