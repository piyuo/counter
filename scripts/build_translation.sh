# script/build_translation.sh
#!/bin/bash
# CSV to ARB Converter Script
# Converts l10n.csv to ARB files for Flutter localization

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default paths
CSV_FILE="${1:-$PROJECT_ROOT/packages/shared_l10n/lib/l10n.csv}"
OUTPUT_DIR="${2:-$PROJECT_ROOT/packages/shared_l10n/lib/generated/}"

echo -e "${YELLOW}🔄 Converting CSV to ARB files...${NC}"
echo "📄 CSV File: $CSV_FILE"
echo "📁 Output Directory: $OUTPUT_DIR"
echo ""

# Check if CSV file exists
if [ ! -f "$CSV_FILE" ]; then
    echo -e "${RED}❌ Error: CSV file not found: $CSV_FILE${NC}"
    echo ""
    echo "Usage: $0 [csv_file] [output_directory]"
    echo "Example: $0 ./lib/l10n/l10n.csv ./lib/l10n/src/"
    exit 1
fi

# Check if output directory exists
if [ ! -d "$OUTPUT_DIR" ]; then
    echo -e "${RED}❌ Error: Output directory not found: $OUTPUT_DIR${NC}"
    exit 1
fi

# Run the Dart script
cd "$SCRIPT_DIR"
dart build_translation.dart "$CSV_FILE" "$OUTPUT_DIR"

echo ""
echo -e "${GREEN}✅ CSV to ARB conversion completed successfully!${NC}"
echo ""
echo -e "${YELLOW}🔄 Generating localization files...${NC}"

# Run flutter gen-l10n from the project root
cd "$PROJECT_ROOT/packages/shared_l10n"
flutter gen-l10n

echo ""
echo -e "${GREEN}✅ Localization files generated successfully!${NC}"
echo ""
echo "📋 Next steps:"
echo "1. Verify the generated ARB files in: $OUTPUT_DIR"
echo "2. Verify the generated Dart localization files"
echo "3. Test your application with the new translations"
