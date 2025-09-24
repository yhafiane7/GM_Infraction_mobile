# Development CI Test Script for Windows
# Run this locally to test what CI will do

Write-Host "Running Development CI Tests Locally..." -ForegroundColor Green

Write-Host "Getting dependencies..." -ForegroundColor Yellow
flutter pub get

Write-Host "Running tests with coverage..." -ForegroundColor Yellow
flutter test --coverage --reporter=expanded

Write-Host "Analyzing code..." -ForegroundColor Yellow
flutter analyze --no-fatal-infos

Write-Host "Checking formatting..." -ForegroundColor Yellow
dart format --output=none --set-exit-if-changed .

Write-Host "Building Debug APK..." -ForegroundColor Yellow
flutter build apk --debug

Write-Host "All development CI checks passed!" -ForegroundColor Green
