#!/bin/bash

SUBTITLE_DIR="release/release_notes"
MAX_LENGTH=500

# Check total file size, not just line length
find "$SUBTITLE_DIR" -type f -name "*.txt" | while read -r file; do
    file_size=$(wc -c < "$file")
    if [ "$file_size" -gt "$MAX_LENGTH" ]; then
        echo "$(basename "$file"): $file_size bytes (exceeds $MAX_LENGTH max)"
    fi
done