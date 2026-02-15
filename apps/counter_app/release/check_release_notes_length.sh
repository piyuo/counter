#!/bin/bash

# Check Release Notes Length Script
# This script validates that all release note entries are within the 500 character limit

# Show help if requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Check Release Notes Length Script"
    echo ""
    echo "DESCRIPTION:"
    echo "  Validates that all release note entries in release_notes.csv are within"
    echo "  the 500 character limit required for app store releases."
    echo ""
    echo "USAGE:"
    echo "  ./check_release_notes_length.sh"
    echo "  ./check_release_notes_length.sh -h|--help"
    echo ""
    echo "EXIT CODES:"
    echo "  0 - All entries are within the limit"
    echo "  1 - One or more entries exceed the 500 character limit"
    echo ""
    echo "FILES:"
    echo "  - release/release_notes.csv (input file)"
    echo "  - check_release_notes_length.py (Python validation script)"
    echo ""
    exit 0
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the Python script
PYTHON_SCRIPT="$SCRIPT_DIR/check_release_notes_length.py"

# Path to the release notes CSV file
CSV_FILE="$SCRIPT_DIR/release/release_notes.csv"

# Check if Python script exists
if [[ ! -f "$PYTHON_SCRIPT" ]]; then
    echo "❌ Error: Python script not found at $PYTHON_SCRIPT"
    exit 1
fi

# Check if CSV file exists
if [[ ! -f "$CSV_FILE" ]]; then
    echo "❌ Error: CSV file not found at $CSV_FILE"
    exit 1
fi

# Run the Python script
echo "🔍 Checking release notes character length limits..."
echo "📁 CSV file: $CSV_FILE"
echo ""

python3 "$PYTHON_SCRIPT"
exit_code=$?

echo ""
if [[ $exit_code -eq 0 ]]; then
    echo "🎉 All release notes are within the 500 character limit!"
else
    echo "⚠️  Some release notes exceed the 500 character limit. Please review and fix them."
fi

exit $exit_code
