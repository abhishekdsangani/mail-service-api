#!/bin/bash

# Quick commit script for Git Bash
# Usage: ./quick-commit.sh "Your commit message"

commit_msg="$1"
if [ -z "$commit_msg" ]; then
    commit_msg="Quick update"
fi

echo "Adding all changes..."
git add .

echo "Committing with message: $commit_msg"
git commit -m "$commit_msg"

echo "Pushing to repository..."
git push

echo "Done!"
read -p "Press any key to continue..."
