#!/bin/bash

# Get the current branch name
BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "🔄 Rolling back the last commit on branch: $BRANCH..."

# 1. Undo the last commit locally but keep the changes in your files
git reset --soft HEAD~1

# 2. Force push to update GitHub (Removing the bad commit from remote)
# Note: --force-with-lease is a safer version of --force
git push origin "$BRANCH" --force-with-lease

echo "✅ Success!"
echo "📝 Your changes are now sitting in VS Code as staged/unstaged changes."
echo "🛠️  Fix your mistakes and commit/push when ready."