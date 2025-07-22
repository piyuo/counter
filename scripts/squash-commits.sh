# Sync with main
git fetch origin
git rebase origin/main

# Clean up commits
git rebase -i origin/main

# In editor: keep first as 'pick', change others to 'squash'
# Edit final commit message following format below

# Push the changes safely (This command is necessary because you've rewritten your branch's history with the rebase. --force-with-lease is the safest way to do this).
git push --force-with-lease
