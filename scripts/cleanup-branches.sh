git fetch --prune # First, prune remote-tracking branches
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D