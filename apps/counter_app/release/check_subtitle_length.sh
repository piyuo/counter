#!/bin/bash

SUBTITLE_DIR="release/subtitle"
MAX_LENGTH=30

# Check total file size, not just line length
find "$SUBTITLE_DIR" -type f -name "*.txt" | while read -r file; do
    file_size=$(wc -c < "$file")
    if [ "$file_size" -gt "$MAX_LENGTH" ]; then
        echo "$(basename "$file"): $file_size bytes (exceeds $MAX_LENGTH max)"
    fi
done