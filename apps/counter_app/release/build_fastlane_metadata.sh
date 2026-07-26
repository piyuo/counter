#!/bin/bash

# build_fastlane_metadata.sh
# Script to copy locale translation files to fastlane metadata directories
# Author: Generated script for Counter app
# Usage: ./build_fastlane_metadata.sh

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

# Translation source directories
DESCRIPTION_DIR="$RELEASE_DIR/description"
KEYWORDS_DIR="$RELEASE_DIR/keywords"
SUBTITLE_DIR="$RELEASE_DIR/subtitle"
RELEASE_NOTES_DIR="$RELEASE_DIR/release_notes"

# Counters
total_locales=0
success_count=0
error_count=0

echo -e "${BLUE}=== Fastlane Metadata Builder ===${NC}"
echo -e "${BLUE}Copying translation files to fastlane metadata directories${NC}"
echo ""

# Function to check if required directories exist
check_dependencies() {
    local missing_dirs=()

    # Check source directories
    for dir in "$DESCRIPTION_DIR" "$KEYWORDS_DIR" "$SUBTITLE_DIR" "$RELEASE_NOTES_DIR"; do
        if [ ! -d "$dir" ]; then
            missing_dirs+=("$dir")
        fi
    done

    # Check target base directories
    for dir in "$IOS_METADATA_DIR" "$MACOS_METADATA_DIR" "$ANDROID_METADATA_DIR"; do
        if [ ! -d "$dir" ]; then
            missing_dirs+=("$dir")
        fi
    done

    if [ ${#missing_dirs[@]} -gt 0 ]; then
        echo -e "${RED}ERROR: Missing required directories:${NC}"
        for dir in "${missing_dirs[@]}"; do
            echo -e "${RED}  - $dir${NC}"
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

    # 1. Process description files
    local desc_file="$DESCRIPTION_DIR/$locale.txt"
    if [ -f "$desc_file" ]; then
        # iOS description
        if copy_file "$desc_file" "$ios_locale_dir/description.txt" "iOS" "description"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi

        # macOS description
        if copy_file "$desc_file" "$macos_locale_dir/description.txt" "macOS" "description"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi

        # Android description
        if copy_file "$desc_file" "$android_locale_dir/full_description.txt" "Android" "description"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi
    else
        echo -e "${YELLOW}  ⚠ Description file not found: $desc_file${NC}"
    fi

    # 2. Process keywords files (iOS and macOS only)
    local keywords_file="$KEYWORDS_DIR/$locale.txt"
    if [ -f "$keywords_file" ]; then
        # iOS keywords
        if copy_file "$keywords_file" "$ios_locale_dir/keywords.txt" "iOS" "keywords"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi

        # macOS keywords
        if copy_file "$keywords_file" "$macos_locale_dir/keywords.txt" "macOS" "keywords"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi
    else
        echo -e "${YELLOW}  ⚠ Keywords file not found: $keywords_file${NC}"
    fi

    # 3. Process subtitle files
    local subtitle_file="$SUBTITLE_DIR/$locale.txt"
    if [ -f "$subtitle_file" ]; then
        # iOS subtitle
        if copy_file "$subtitle_file" "$ios_locale_dir/subtitle.txt" "iOS" "subtitle"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi

        # macOS subtitle
        if copy_file "$subtitle_file" "$macos_locale_dir/subtitle.txt" "macOS" "subtitle"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi

        # Android subtitle (short_description)
        if copy_file "$subtitle_file" "$android_locale_dir/short_description.txt" "Android" "subtitle"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi
    else
        echo -e "${YELLOW}  ⚠ Subtitle file not found: $subtitle_file${NC}"
    fi

    # 4. Process release notes files
    local release_notes_file="$RELEASE_NOTES_DIR/$locale.txt"
    if [ -f "$release_notes_file" ]; then
        # iOS release notes
        if copy_file "$release_notes_file" "$ios_locale_dir/release_notes.txt" "iOS" "release_notes"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi

        # macOS release notes
        if copy_file "$release_notes_file" "$macos_locale_dir/release_notes.txt" "macOS" "release_notes"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi

        # Android release notes (requires changelogs directory)
        local android_changelogs_dir="$android_locale_dir/changelogs"
        if copy_file "$release_notes_file" "$android_changelogs_dir/default.txt" "Android" "release_notes"; then
            ((locale_success++))
        else
            ((locale_errors++))
        fi
    else
        echo -e "${YELLOW}  ⚠ Release notes file not found: $release_notes_file${NC}"
    fi

    # Update global counters
    success_count=$((success_count + locale_success))
    error_count=$((error_count + locale_errors))

    echo -e "${BLUE}  Locale $locale: $locale_success successes, $locale_errors errors${NC}"
    echo ""
}

# Main execution
echo -e "${BLUE}Checking dependencies...${NC}"
check_dependencies

echo -e "${BLUE}Source directories:${NC}"
echo -e "  - Description: $DESCRIPTION_DIR"
echo -e "  - Keywords: $KEYWORDS_DIR"
echo -e "  - Subtitle: $SUBTITLE_DIR"
echo -e "  - Release Notes: $RELEASE_NOTES_DIR"
echo ""

echo -e "${BLUE}Target directories:${NC}"
echo -e "  - iOS: $IOS_METADATA_DIR"
echo -e "  - macOS: $MACOS_METADATA_DIR"
echo -e "  - Android: $ANDROID_METADATA_DIR"
echo ""

# Get list of all unique locales from all translation directories
echo -e "${BLUE}Discovering locales...${NC}"
locales=()

for dir in "$DESCRIPTION_DIR" "$KEYWORDS_DIR" "$SUBTITLE_DIR" "$RELEASE_NOTES_DIR"; do
    if [ -d "$dir" ]; then
        for file in "$dir"/*.txt; do
            if [ -f "$file" ]; then
                locale=$(basename "$file" .txt)
                if [[ ! " ${locales[@]} " =~ " ${locale} " ]]; then
                    locales+=("$locale")
                fi
            fi
        done
    fi
done

# Sort locales alphabetically
IFS=$'\n' locales=($(sort <<<"${locales[*]}"))
total_locales=${#locales[@]}

echo -e "${BLUE}Found $total_locales unique locales${NC}"
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
echo -e "  • description/[locale].txt → iOS/macOS: description.txt, Android: full_description.txt"
echo -e "  • keywords/[locale].txt → iOS/macOS: keywords.txt (Android: not used)"
echo -e "  • subtitle/[locale].txt → iOS/macOS: subtitle.txt, Android: short_description.txt"
echo -e "  • release_notes/[locale].txt → iOS/macOS: release_notes.txt, Android: changelogs/default.txt"

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  - Review the copied metadata files"
echo -e "  - Run fastlane commands for your target platforms"
echo -e "  - iOS: cd ios && fastlane release"
echo -e "  - macOS: cd macos && fastlane release"
echo -e "  - Android: cd android && fastlane release"
