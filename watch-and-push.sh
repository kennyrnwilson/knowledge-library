#!/bin/bash

# File watcher that automatically commits and pushes changes
# This runs in the background and watches for file changes

REPO_DIR="/home/kenne/projects/knowledge-library"
SLEEP_INTERVAL=10  # Check every 10 seconds

echo "Starting file watcher for auto-commit and push..."
echo "Watching directory: $REPO_DIR"
echo "Checking for changes every $SLEEP_INTERVAL seconds"
echo "Press Ctrl+C to stop"
echo ""

cd "$REPO_DIR" || exit 1

while true; do
    # Check if there are any changes
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Changes detected, committing and pushing..."

        # Add all changes
        git add .

        # Create commit with timestamp
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        git commit -m "Auto-save: $TIMESTAMP"

        # Push to remote
        if git push; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Successfully pushed changes"
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Failed to push changes"
        fi

        echo ""
    fi

    # Wait before next check
    sleep $SLEEP_INTERVAL
done
