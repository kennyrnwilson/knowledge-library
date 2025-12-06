#!/bin/bash

# Auto-commit and push script for knowledge-library

# Add all changes
git add .

# Check if there are changes to commit
if git diff-index --quiet HEAD --; then
    echo "No changes to commit"
    exit 0
fi

# Create commit message with timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
COMMIT_MSG="Auto-save: $TIMESTAMP"

# Commit changes
git commit -m "$COMMIT_MSG"

# Push to remote
git push

echo "Changes committed and pushed successfully!"
