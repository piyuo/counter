#!/bin/bash

# cleanup_android_locales.sh
# Script to remove Android fastlane metadata folders for locales not in Google Play accepted list
# Author: Generated script for Counter app
# Usage: ./cleanup_android_locales.sh [--dry-run]

set -e  # Exit on any error

# Parse command line arguments
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
fi

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
LOCALES_CSV="$SCRIPT_DIR/locales_google_play_accepted.csv"
ANDROID_METADATA_DIR="$PROJECT_ROOT/android/fastlane/metadata/android"

# Counters
folders_checked=0
folders_removed=0
folders_kept=0

echo -e "${BLUE}=== Android Locales Cleanup ===${NC}"
if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}🔍 DRY RUN MODE - No files will be removed${NC}"
else
    echo -e "${BLUE}Removing Android fastlane metadata folders for unsupported locales${NC}"
fi
echo ""

# Function to check if required files and directories exist
check_dependencies() {
    local missing_items=()

    # Check CSV file
    if [ ! -f "$LOCALES_CSV" ]; then
        missing_items+=("$LOCALES_CSV")
    fi

    # Check Android metadata directory
    if [ ! -d "$ANDROID_METADATA_DIR" ]; then
        missing_items+=("$ANDROID_METADATA_DIR")
    fi

    if [ ${#missing_items[@]} -gt 0 ]; then
        echo -e "${RED}❌ Error: Missing required files/directories:${NC}"
        for item in "${missing_items[@]}"; do
            echo -e "  - $item"
        done
        exit 1
    fi
}

# Function to parse CSV and extract accepted locales
get_accepted_locales() {
    local csv_file="$1"
    local accepted_locales=()

    # Read the first line (header) from CSV
    local header=$(head -n 1 "$csv_file")

    # Parse CSV header, splitting by comma and trimming whitespace
    IFS=',' read -ra ADDR <<< "$header"

    # Skip the first column ('key') and collect the rest as locales
    for i in "${ADDR[@]:1}"; do
        # Trim leading/trailing whitespace
        locale=$(echo "$i" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        # Skip empty locales
        if [ -n "$locale" ]; then
            accepted_locales+=("$locale")
        fi
    done

    # Return the array (print each element on a new line)
    printf '%s\n' "${accepted_locales[@]}"
}

# Function to check if locale is in accepted list
is_locale_accepted() {
    local locale="$1"
    local -a accepted_locales=("${@:2}")

    for accepted in "${accepted_locales[@]}"; do
        if [ "$locale" = "$accepted" ]; then
            return 0  # Found
        fi
    done
    return 1  # Not found
}

# Function to remove a folder
remove_folder() {
    local folder_path="$1"
    local folder_name="$2"

    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}  🔍 Would remove: $folder_name${NC}"
        ((folders_removed++))
        return 0
    else
        if rm -rf "$folder_path"; then
            echo -e "${RED}  ❌ Removed: $folder_name${NC}"
            ((folders_removed++))
            return 0
        else
            echo -e "${RED}  ❌ Failed to remove: $folder_name${NC}"
            return 1
        fi
    fi
}

# Main execution
echo -e "${BLUE}Checking dependencies...${NC}"
check_dependencies

echo -e "${BLUE}Source files:${NC}"
echo -e "  - Locales CSV: $LOCALES_CSV"
echo -e "  - Android metadata: $ANDROID_METADATA_DIR"
echo ""

# Get accepted locales from CSV
echo -e "${BLUE}Loading accepted locales from CSV...${NC}"
accepted_locales=()
while IFS= read -r locale; do
    accepted_locales+=("$locale")
done < <(get_accepted_locales "$LOCALES_CSV")

echo -e "${BLUE}Found ${#accepted_locales[@]} accepted locales:${NC}"
# Print first few locales as preview
preview_count=$((${#accepted_locales[@]} < 10 ? ${#accepted_locales[@]} : 10))
for i in $(seq 0 $((preview_count - 1))); do
    echo -e "  - ${accepted_locales[$i]}"
done
if [ ${#accepted_locales[@]} -gt 10 ]; then
    echo -e "  - ... and $((${#accepted_locales[@]} - 10)) more"
fi
echo ""

# Scan Android metadata directory for locale folders
echo -e "${BLUE}Scanning Android metadata directory...${NC}"
echo ""

# Get all directories in Android metadata folder
for folder_path in "$ANDROID_METADATA_DIR"/*/; do
    # Check if it's actually a directory
    if [ -d "$folder_path" ]; then
        # Extract folder name (locale)
        folder_name=$(basename "$folder_path")
        ((folders_checked++))

        # Check if this locale is in the accepted list
        if is_locale_accepted "$folder_name" "${accepted_locales[@]}"; then
            echo -e "${GREEN}  ✅ Keeping: $folder_name${NC}"
            ((folders_kept++))
        else
            echo -e "${YELLOW}  🔍 Not in accepted list: $folder_name${NC}"
            remove_folder "$folder_path" "$folder_name"
        fi
    fi
done

echo ""
echo -e "${BLUE}=== Summary ===${NC}"
echo -e "Total folders checked: $folders_checked"
echo -e "${GREEN}Folders kept: $folders_kept${NC}"
if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}Folders that would be removed: $folders_removed${NC}"
else
    echo -e "${RED}Folders removed: $folders_removed${NC}"
fi

if [ $folders_removed -gt 0 ]; then
    echo ""
    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}⚠️  Warning: $folders_removed locale folder(s) would be removed.${NC}"
        echo -e "${YELLOW}   Run without --dry-run to actually remove them.${NC}"
    else
        echo -e "${YELLOW}⚠️  Warning: $folders_removed locale folder(s) were removed.${NC}"
        echo -e "${YELLOW}   Make sure this is intended before proceeding with fastlane deployment.${NC}"
    fi
fi

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  - Review the remaining locale folders in: $ANDROID_METADATA_DIR"
echo -e "  - Verify your fastlane metadata is correct"
echo -e "  - Run your Android release: cd android && fastlane release"

echo ""
echo -e "${GREEN}✅ Android locales cleanup completed!${NC}"

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  - Review the remaining locale folders in: $ANDROID_METADATA_DIR"
echo -e "  - Verify your fastlane metadata is correct"
echo -e "  - Run your Android release: cd android && fastlane release"

echo ""
echo -e "${GREEN}✅ Android locales cleanup completed!${NC}"
