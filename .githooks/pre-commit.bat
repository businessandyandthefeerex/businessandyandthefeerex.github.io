@echo off
REM This is the Git pre-commit hook for Windows

REM Navigate to the repo directory and run the Ruby script
cd %CD%

REM Check if Ruby is available
where ruby >nul 2>nul
if %errorlevel% neq 0 (
  echo Ruby is not installed. Please install Ruby and try again.
  exit /b 1
)

REM Set the absolute path for the Ruby script
SET RUBY_SCRIPT=C:/repos/businessandyandthefeerex.github.io/assets/scripts/generate_map_export.rb

REM Run the Ruby script to generate the CSV
ruby "%RUBY_SCRIPT%"

REM If Ruby script ran successfully, continue with the commit
if %errorlevel% neq 0 (
  echo Ruby script failed. Commit aborted.
  exit /b 1
)

REM Continue with the commit
exit /b 0
