# Design Decisions: TIGU Mentor App Visual Upgrade

## Overview
The "Olive-glow + Neumorphic" upgrade pivots the TIGU Mentor app to a more premium, mature, and focused aesthetic suitable for high-value content creators and educators. 

### 1. Color Palette (Tokens)
- **Primary Olive (`#4A5A23`)**: Replaces the generic default material purple/blue. Olive evokes growth, money (Wallet), and learning.
- **Accent Glow (`#BFF48A`)**: Used sparingly for data visualization (Dashboard charts) and progress indicators to create a "neon on dark" high-tech feel without being overwhelming.
- **Status Colors (`#xFFFF4D`, etc.)**: Normalized to standard traffic-light colors but slightly desaturated to fit the premium aesthetic. 

### 2. Neumorphism & Soft UI
- **Inputs & Cards**: We introduced soft shadows (white highlights on top-left, dark soft shadows on bottom-right) to `AppTextField` and cards. This physical depth improves the tactility of the interface, making data entry (Profile editing) feel more localized and tangible. 
- **Glassmorphism**: Applied to the Wallet header and Withdraw modals. Using `BackdropFilter` with `sigmaX/Y: 20` enables the rich olive gradients to shine through the frosted glass, reinforcing trust and financial transparency.

### 3. Layouts & Empty States
- **Courses Screen**: Migrated from a standard `ListView` to a `GridView` (2 columns). This makes better use of screen real-estate and allows thumbnails to breathe.
- **Lazy Loading**: Integrated `cached_network_image` to ensure thumbnails load smoothly without locking the main thread.
- **Skeleton Loaders**: Replaced static loading spinners with shimmering placeholder skeletons on the Wallet and Students lists to reduce perceived wait times.

### 4. Code Organization
- Built a definitive `AppTokens` class in `lib/core/design/tokens.dart` replacing the spread-out hardcoded colors and `AppTheme` singletons. This allows direct reference to semantic values (`AppTokens.spacingMd` instead of hardcoded `16.0`) ensuring pixel-perfect alignment globally. 
