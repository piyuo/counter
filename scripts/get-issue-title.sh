#!/bin/bash

# This script fetches the title of a GitHub issue using its number.
# Requirements: GitHub CLI (`gh`) must be installed and authenticated.

set -e
export GH_DEBUG=0  # Disable debug output

if [ -z "$1" ]; then
    echo "❌ Error: Issue number is required."
    echo "Usage: $0 <issue-number>"
    exit 1
fi

ISSUE_NUMBER="$1"

# Disable pager for clean output
TITLE=$(GH_PAGER= gh issue view "$ISSUE_NUMBER" --json title --jq .title)

if [ -z "$TITLE" ]; then
    echo "❌ Error: Could not fetch issue title."
    exit 1
fi

echo "$TITLE"
