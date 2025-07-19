@echo off
:: Quick commit script - commits and pushes with a simple message

set commit_msg=%1
if "%commit_msg%"=="" set commit_msg=Quick update

echo Adding all changes...
git add .

echo Committing with message: %commit_msg%
git commit -m "%commit_msg%"

echo Pushing to repository...
git push

echo Done!
pause
