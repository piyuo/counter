#!/bin/bash

# Script to collect translation files into CSV format
# Usage: ./translation_csv.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCALES_CSV="$SCRIPT_DIR/locales.csv"
OUTPUT_CSV="$SCRIPT_DIR/translation.csv"

# Translation folders
FOLDERS=("description" "keywords" "release_notes" "subtitle")

# Function to escape CSV content
escape_csv() {
    local content="$1"
    # Always wrap in quotes and escape internal quotes
    echo "\"${content//\"/\"\"}\""
}

# Function to read file content and clean it
read_file_content() {
    local file="$1"
    if [[ -f "$file" ]]; then
        # Read file, remove trailing whitespace and newlines
        content=$(cat "$file" | sed 's/[[:space:]]*$//' | tr '\n' ' ' | sed 's/[[:space:]]*$//')
        echo "$content"
    else
        echo ""
    fi
}

# Function to count CSV columns properly (handles quoted fields)
count_csv_columns() {
    local line="$1"
    # Use awk to properly parse CSV and count fields
    echo "$line" | awk -F',' '
    {
        count = 0
        inquote = 0
        for (i = 1; i <= length($0); i++) {
            char = substr($0, i, 1)
            if (char == "\"") {
                if (inquote && substr($0, i+1, 1) == "\"") {
                    i++ # Skip escaped quote
                } else {
                    inquote = !inquote
                }
            } else if (char == "," && !inquote) {
                count++
            }
        }
        print count + 1
    }'
}

echo "Generating translation CSV from locales.csv format..."

# Check if locales.csv exists
if [[ ! -f "$LOCALES_CSV" ]]; then
    echo "Error: locales.csv not found in $SCRIPT_DIR"
    exit 1
fi

# Read header from locales.csv
header=$(head -n 1 "$LOCALES_CSV")
echo "$header" > "$OUTPUT_CSV"

# Get locale codes from header (skip first column 'key')
IFS=',' read -ra LOCALE_CODES <<< "$header"
locale_codes=("${LOCALE_CODES[@]:1}") # Remove 'key' column

echo "Found ${#locale_codes[@]} locale codes"

# Process each folder
for folder in "${FOLDERS[@]}"; do
    folder_path="$SCRIPT_DIR/$folder"

    if [[ ! -d "$folder_path" ]]; then
        echo "Warning: Folder $folder_path does not exist, skipping..."
        continue
    fi

    echo "Processing folder: $folder"

    # Start building the row
    row="$folder"

    # For each locale code, try to find the corresponding file
    for locale in "${locale_codes[@]}"; do
        # Clean locale code (remove quotes if any)
        clean_locale=$(echo "$locale" | sed 's/^"//;s/"$//')

        # Try different file extensions and patterns
        file_found=false
        for ext in ".txt"; do
            file_path="$folder_path/${clean_locale}${ext}"
            if [[ -f "$file_path" ]]; then
                content=$(read_file_content "$file_path")
                escaped_content=$(escape_csv "$content")
                row="$row,$escaped_content"
                file_found=true
                break
            fi
        done

        # If no file found, add empty column
        if [[ "$file_found" = false ]]; then
            row="$row,\"\""
        fi
    done

    # Add row to CSV
    echo "$row" >> "$OUTPUT_CSV"
done

echo "Translation CSV generated: $OUTPUT_CSV"
echo

# Validate CSV format - check column counts
echo "Validating CSV format..."
echo

# Count columns in header
header_count=$(count_csv_columns "$header")
echo "Header column count: $header_count"

# Check each data row
line_num=1
all_correct=true

while IFS= read -r line; do
    ((line_num++))

    if [[ -n "$line" ]]; then
        # Count columns in current line
        column_count=$(count_csv_columns "$line")

        # Extract row key (first column)
        row_key=$(echo "$line" | cut -d',' -f1)

        echo "Row '$row_key' (line $line_num): $column_count columns"

        if [[ "$column_count" -ne "$header_count" ]]; then
            echo "ERROR: Row '$row_key' has $column_count columns, expected $header_count"
            all_correct=false
        fi
    fi
done < <(tail -n +2 "$OUTPUT_CSV")

echo

if [[ "$all_correct" = true ]]; then
    echo "✅ OK - All rows have correct column count ($header_count columns)"
else
    echo "❌ ERROR - Some rows have incorrect column count"
    exit 1
fi

echo
echo "Translation CSV validation complete!"
echo "Output file: $OUTPUT_CSV"