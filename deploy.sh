#!/bin/bash

# 1. Variables
APP_ID="1:939177465750:android:3c337dae3b36c2e956efb7"
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"

echo "🚀 Starting Deployment Process..."

# 2. Clean and Build
echo "📦 Building Release APK..."
flutter clean
flutter pub get
flutter build apk --release

# 3. Check if build was successful
if [ -f "$APK_PATH" ]; then
    echo "✅ Build Successful! Sending to Firebase..."
    
    # 4. Upload to App Distribution
    firebase appdistribution:distribute "$APK_PATH" \
        --app "$APP_ID" \
        --release-notes "Build at $(date '+%Y-%m-%d %H:%M:%S') - Manual Touch-ups" \
        --groups "testers"
        
    echo "🎉 Done! Check your phone for the notification."
else
    echo "❌ Build Failed. Check the errors above."
    exit 1
fi

