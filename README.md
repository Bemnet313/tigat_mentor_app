# TIGU Mentor App 🚀

Welcome to the **TIGU Mentor App**, the premier hub designed specifically for content creators and educators to launch, manage, and monetize their communities seamlessly.

## 📖 The "Why"
Managing a community and creating educational content often requires juggling multiple tools—from chat apps to video hosting and payment processors. **TIGU Mentor** consolidates these workflows into a single, premium mobile experience. We empower creators to focus on what matters most: growing their audience and delivering value, while we handle the distribution, community engagement, and monetization architecture.

## ✨ Features
1. **Interactive Dashboard**: Track your revenue, active students, and content metrics in real-time.
2. **Community Management**: Moderate chat rooms, engage with followers, and broadcast announcements instantly.
3. **Student Directory**: Monitor student progress, handle subscriptions, and manage user access gracefully.
4. **Courses Hub**: Easily upload, edit, and curate full-fledged video courses from your mobile device.
5. **Integrated Wallet**: Instant insights into your earnings with a one-tap withdrawal system straight to your bank.
6. **Smart Content Creator**: A robust modal to draft text-posts, attach media, or schedule announcements across your community.

## 🛠 Tech Stack
- **Frontend Framework**: Flutter (Dart)
- **Architecture**: Feature-First Folder Structure
- **Backend & Auth**: Firebase / FlutterFire (Authentication, Firestore, Storage)
- **Data Visualization**: `fl_chart` for dynamic revenue graphing
- **State Management**: `provider` + `go_router` for declarative navigation

## 🚀 Setup Instructions for Developers

### Prerequisites
- Flutter SDK (`>=3.19.0`)
- Dart SDK (`>=3.3.0`)
- Firebase CLI installed (`npm install -g firebase-tools`)
- FlutterFire CLI installed (`dart pub global activate flutterfire_cli`)

### Getting Started

1. **Clone the repository** (Ensure you have access to the private repo):
   ```bash
   git clone <your-private-repo-url>
   cd tigat_mentor_app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**:
   This project relies on Firebase, but API keys are omitted from version control for security.
   You must retrieve the following keys from your PM or configure your own Firebase project:
   - Place `google-services.json` inside `android/app/`
   - Place `GoogleService-Info.plist` inside `ios/Runner/`
   
   Alternatively, you can run the FlutterFire CLI to generate your local configurations:
   ```bash
   flutterfire configure --project tigat-mentor
   ```
   *(Note: The generated `lib/firebase_options.dart` is git-ignored to prevent accidental public leaks)*

4. **Run the App**:
   ```bash
   flutter run
   ```

## 🤝 Contribution Guidelines
When contributing to this project, please adhere to our strict **Feature-First** architecture:
- Place all screen logic under `lib/features/<feature_name>/screens/`.
- Use `lib/core/theme/theme.dart` for all UI coloration and text styling. Avoid hardcoded hex codes.
- Add text strings to `lib/core/constants/app_strings.dart` for clean localization integration.

---
*Developed with ❤️ for the TIGU ecosystem.*
