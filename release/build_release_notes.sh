#!/bin/bash

# build_release_notes.sh
# Script to read centralized release_notes.csv and convert each field to [locale].txt
# Then call build_fastlane_metadata.sh to deploy changes to fastlane folders
# Author: Generated script for Counter app
# Usage: ./build_release_notes.sh

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
RELEASE_NOTES_CSV="$RELEASE_DIR/release_notes.csv"
RELEASE_NOTES_OUTPUT_DIR="$RELEASE_DIR/release_notes"
FASTLANE_METADATA_SCRIPT="$RELEASE_DIR/build_fastlane_metadata.sh"

# Counters
total_locales=0
success_count=0
error_count=0

echo -e "${BLUE}=== Release Notes Builder ===${NC}"
echo -e "${BLUE}Converting CSV translations to individual locale files${NC}"
echo ""

# Function to check if required files exist
check_dependencies() {
    local missing_items=()

    # Check source CSV file
    if [ ! -f "$RELEASE_NOTES_CSV" ]; then
        missing_items+=("$RELEASE_NOTES_CSV")
    fi

    # Check fastlane metadata script
    if [ ! -f "$FASTLANE_METADATA_SCRIPT" ]; then
        missing_items+=("$FASTLANE_METADATA_SCRIPT")
    fi

    if [ ${#missing_items[@]} -gt 0 ]; then
        echo -e "${RED}ERROR: Missing required files:${NC}"
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

# Function to clean existing release notes files
clean_existing_files() {
    if [ -d "$RELEASE_NOTES_OUTPUT_DIR" ]; then
        echo -e "${YELLOW}Cleaning existing release notes files...${NC}"
        rm -f "$RELEASE_NOTES_OUTPUT_DIR"/*.txt
    fi
}

# Function to process CSV and create locale files
process_csv() {
    local csv_file="$1"
    local output_dir="$2"

    echo -e "${BLUE}Reading CSV file: $csv_file${NC}"

    # Create output directory
    create_dir_if_not_exists "$output_dir"

    # Read the CSV file using Python for proper CSV parsing
    python3 << EOF
import csv
import sys
import os

csv_file = "$csv_file"
output_dir = "$output_dir"

try:
    with open(csv_file, 'r', encoding='utf-8') as file:
        reader = csv.DictReader(file)

        # Find the row with key="notes"
        notes_row = None
        for row in reader:
            if row.get('key') == 'notes':
                notes_row = row
                break

        if not notes_row:
            print("ERROR: No 'notes' row found in CSV", file=sys.stderr)
            sys.exit(1)

        # Process each locale column (skip the 'key' column)
        locales_processed = 0
        for locale, content in notes_row.items():
            if locale == 'key' or not locale or locale == 'None' or str(locale).strip() == '':
                continue

            # Ensure content is a string
            if isinstance(content, list):
                content = ' '.join(str(item) for item in content)
            content = str(content) if content is not None else ""

            if content and content.strip():
                # Clean the content (remove extra quotes if present)
                content = content.strip()
                if content.startswith('"') and content.endswith('"'):
                    content = content[1:-1]

                # Replace escaped newlines with actual newlines
                content = content.replace('\\\\n', '\n')

                # Write to locale file
                output_file = os.path.join(output_dir, f"{locale}.txt")
                try:
                    with open(output_file, 'w', encoding='utf-8') as out_file:
                        out_file.write(content)
                    print(f"✓ Created: {locale}.txt")
                    locales_processed += 1
                except Exception as e:
                    print(f"✗ Failed to create {locale}.txt: {e}", file=sys.stderr)
            else:
                print(f"⚠ Skipping empty content for locale: {locale}")

        print(f"Total locales processed: {locales_processed}")

except Exception as e:
    print(f"ERROR: Failed to process CSV: {e}", file=sys.stderr)
    sys.exit(1)
EOF

    local python_exit_code=$?
    if [ $python_exit_code -ne 0 ]; then
        echo -e "${RED}Failed to process CSV file${NC}"
        exit 1
    fi
}

# Function to count created files
count_created_files() {
    local output_dir="$1"
    if [ -d "$output_dir" ]; then
        local file_count=$(find "$output_dir" -name "*.txt" -type f | wc -l)
        echo $file_count
    else
        echo 0
    fi
}

# Function to call fastlane metadata script
deploy_to_fastlane() {
    local script_path="$1"

    echo ""
    echo -e "${BLUE}=== Deploying to Fastlane Metadata ===${NC}"
    echo -e "${BLUE}Calling: $script_path${NC}"
    echo ""

    if [ -x "$script_path" ]; then
        # Make sure the script is executable and call it
        "$script_path"
        local exit_code=$?

        if [ $exit_code -eq 0 ]; then
            echo ""
            echo -e "${GREEN}✓ Fastlane metadata deployment completed successfully${NC}"
        else
            echo ""
            echo -e "${RED}✗ Fastlane metadata deployment failed with exit code: $exit_code${NC}"
            exit 1
        fi
    else
        echo -e "${RED}ERROR: Fastlane metadata script is not executable: $script_path${NC}"
        echo -e "${YELLOW}Making script executable...${NC}"
        chmod +x "$script_path"

        # Try again
        "$script_path"
        local exit_code=$?

        if [ $exit_code -eq 0 ]; then
            echo ""
            echo -e "${GREEN}✓ Fastlane metadata deployment completed successfully${NC}"
        else
            echo ""
            echo -e "${RED}✗ Fastlane metadata deployment failed with exit code: $exit_code${NC}"
            exit 1
        fi
    fi
}

# Main execution
echo -e "${BLUE}Checking dependencies...${NC}"
check_dependencies

echo -e "${BLUE}Source CSV: $RELEASE_NOTES_CSV${NC}"
echo -e "${BLUE}Output directory: $RELEASE_NOTES_OUTPUT_DIR${NC}"
echo -e "${BLUE}Fastlane script: $FASTLANE_METADATA_SCRIPT${NC}"
echo ""

# Clean existing files
clean_existing_files

# Process CSV and create locale files
echo -e "${CYAN}Processing CSV file...${NC}"
process_csv "$RELEASE_NOTES_CSV" "$RELEASE_NOTES_OUTPUT_DIR"

# Count created files
total_locales=$(count_created_files "$RELEASE_NOTES_OUTPUT_DIR")

# Summary of CSV processing
echo ""
echo -e "${BLUE}=== CSV Processing Summary ===${NC}"
echo -e "Total locale files created: $total_locales"

if [ $total_locales -gt 0 ]; then
    echo -e "${GREEN}✓ Release notes files created successfully${NC}"

    # Show some examples of created files
    echo ""
    echo -e "${BLUE}Created files (showing first 5):${NC}"
    ls -1 "$RELEASE_NOTES_OUTPUT_DIR"/*.txt 2>/dev/null | head -5 | while read file; do
        echo -e "  - $(basename "$file")"
    done

    if [ $total_locales -gt 5 ]; then
        echo -e "  ... and $((total_locales - 5)) more"
    fi

    # Deploy to fastlane
    deploy_to_fastlane "$FASTLANE_METADATA_SCRIPT"

else
    echo -e "${RED}✗ No locale files were created${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}=== Final Summary ===${NC}"
echo -e "${GREEN}✓ Release notes extraction: $total_locales locale files created${NC}"
echo -e "${GREEN}✓ Fastlane metadata deployment: Completed${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  - Review the generated files in: $RELEASE_NOTES_OUTPUT_DIR"
echo -e "  - Review the deployed fastlane metadata files"
echo -e "  - Run fastlane commands for your target platforms:"
echo -e "    • iOS: cd ios && fastlane release"
echo -e "    • macOS: cd macos && fastlane release"
echo -e "    • Android: cd android && fastlane release"
