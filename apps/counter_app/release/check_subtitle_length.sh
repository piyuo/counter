#!/bin/bash

SUBTITLE_DIR="release/subtitle"
MAX_LENGTH=30

find "$SUBTITLE_DIR" -type f -name "*.txt" | while read -r file; do
    if awk -v max="$MAX_LENGTH" 'length($0) > max { exit 1 }' "$file"; then
        :
    else
        echo "$(basename "$file")"
    fi
done