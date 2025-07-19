#!/bin/bash

# Git Sync Script for Mail Service API
# Works with Git Bash on Windows

REPO_URL="https://github.com/abhishekdsangani/mail-service-api.git"
BRANCH="main"

echo "========================================"
echo "Git Sync Script for Mail Service API"
echo "========================================"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "ERROR: Git is not installed or not in PATH"
    read -p "Press any key to continue..."
    exit 1
fi

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git remote add origin "$REPO_URL"
    echo "Repository initialized and remote added."
fi

# Check if remote origin exists, if not add it
if ! git remote get-url origin &> /dev/null; then
    echo "Adding remote origin..."
    git remote add origin "$REPO_URL"
fi

echo
echo "Step 1: Checking repository status..."
git status

echo
echo "Step 2: Adding all changes to staging..."
git add .

# Check if there are any changes to commit
if ! git diff-index --quiet HEAD --; then
    echo
    echo "Step 3: Committing changes..."
    read -p "Enter commit message (or press Enter for default): " commit_message
    if [ -z "$commit_message" ]; then
        commit_message="Auto-commit: Updates on $(date)"
    fi
    git commit -m "$commit_message"
else
    echo
    echo "No changes to commit."
fi

echo
echo "Step 4: Pulling latest changes from remote..."
if ! git pull origin "$BRANCH" --rebase; then
    echo
    echo "WARNING: Pull failed. This might be the first push to an empty repository."
    echo "Attempting to push with --set-upstream..."
    git push --set-upstream origin "$BRANCH"
else
    echo
    echo "Step 5: Pushing changes to remote repository..."
    git push origin "$BRANCH"
fi

if [ $? -eq 0 ]; then
    echo
    echo "SUCCESS: All changes have been synchronized!"
    echo "Repository URL: $REPO_URL"
else
    echo
    echo "ERROR: Push failed. Please check your credentials and repository URL."
    echo "Make sure you have push access to the repository."
    echo
    echo "Current remote URL: $REPO_URL"
    echo "You may need to:"
    echo "1. Verify the repository URL is correct"
    echo "2. Check your GitHub credentials"
    echo "3. Ensure you have push permissions"
fi

echo
echo "========================================"
echo "Git sync completed!"
echo "========================================"
read -p "Press any key to continue..."
