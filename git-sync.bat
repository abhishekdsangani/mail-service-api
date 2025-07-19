@echo off
setlocal

:: Set the repository URL (you need to replace this with your actual GitHub repository URL)
set REPO_URL=https://github.com/abhishekdsangani/mail-service-api.git
set BRANCH=main

echo ========================================
echo Git Sync Script for Mail Service API
echo ========================================

:: Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed or not in PATH
    pause
    exit /b 1
)

:: Check if we're in a git repository
if not exist ".git" (
    echo Initializing git repository...
    git init
    git remote add origin %REPO_URL%
    echo Repository initialized and remote added.
)

:: Check if remote origin exists, if not add it
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo Adding remote origin...
    git remote add origin %REPO_URL%
)

echo.
echo Step 1: Checking repository status...
git status

echo.
echo Step 2: Adding all changes to staging...
git add .

:: Check if there are any changes to commit
git diff-index --quiet HEAD --
if errorlevel 1 (
    echo.
    echo Step 3: Committing changes...
    set /p commit_message="Enter commit message (or press Enter for default): "
    if "%commit_message%"=="" (
        set commit_message=Auto-commit: Updates on %date% %time%
    )
    git commit -m "%commit_message%"
) else (
    echo.
    echo No changes to commit.
)

echo.
echo Step 4: Pulling latest changes from remote...
git pull origin %BRANCH% --rebase

if errorlevel 1 (
    echo.
    echo WARNING: Pull failed. This might be the first push to an empty repository.
    echo Attempting to push with --set-upstream...
    git push --set-upstream origin %BRANCH%
) else (
    echo.
    echo Step 5: Pushing changes to remote repository...
    git push origin %BRANCH%
)

if errorlevel 1 (
    echo.
    echo ERROR: Push failed. Please check your credentials and repository URL.
    echo Make sure you have push access to the repository.
    echo.
    echo Current remote URL: %REPO_URL%
    echo You may need to:
    echo 1. Verify the repository URL is correct
    echo 2. Check your GitHub credentials
    echo 3. Ensure you have push permissions
    pause
    exit /b 1
) else (
    echo.
    echo SUCCESS: All changes have been synchronized!
    echo Repository URL: %REPO_URL%
)

echo.
echo ========================================
echo Git sync completed!
echo ========================================
pause
