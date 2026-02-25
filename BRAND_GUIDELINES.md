# TIGU Mentor App - Brand Guidelines

## 1. Brand Identity & Vibe
The TIGU Mentor app leverages a **Warm Olive** aesthetic, designed to convey maturity, professionalism, stability, and growth. We have moved away from harsh neon colors towards a softer, slightly muted spectrum with calm undertones.

## 2. Color Palette & Tokens
Always use `AppTokens` for colors rather than raw generic colors (`Colors.white`, `Colors.black`, `Colors.grey`).

### Primary Colors
- **Primary Olive (`#4A5A23`)**: The core brand color. Used for prominent active actions, filled buttons, and primary indicators.
- **Primary Olive Dark (`#1F2A14`)**: Used for high-contrast dark backgrounds, hero gradients, and dark mode bases.
- **Accent Glow (`#B7D77A`)**: Used sparingly for highlights, success indicators, and subtle glowing effects.
- **Accent Soft (`#E3F2C6`)**: Used to create a warm blend in gradients or as a very soft highlight background.

### UI & Surface Colors
- **Background Light (`#FFFFFF`)**: Pure white reserved for the main Light mode canvas.
- **Surface Elevated (`#F6F8F3`)**: A very soft off-white used for cards, text fields, and elevated elements in Light mode.
- **Overlay Light (`1F2A14` @ 4% alpha)**: For subtle dark washes, inactive button backgrounds, and soft separations.
- **Overlay Dark (`1F2A14` @ 30% alpha)**: For modal backdrops and aggressive darkening over images/banners.
- **Border Subtle (`6C7563` @ 10% alpha)**: Standard border for cards, buttons, and text fields.

### Status Colors
- **Status Red (`#FF4D4D`)**: Errors, destructive actions, rejected states.
- **Status Warning (`#FFB800`)**: Pending states, warnings, non-critical alerts.

## 3. Typography
The app uses **Noto Sans** extensively. Colors are driven by `AppTokens`:
- **Text Primary (`#1F2E1E`)**: High contrast text, headers, and primary body content.
- **Text Secondary (`#6C7563`)**: Subtitles, less important body content, unselected states.
- **Text Tertiary (`#9AA696`)**: Extremely demoted text, hints, placeholders, and subtle metadata.

## 4. Components & Elevation

### Buttons
All prominent buttons (Filled, Outlined) should utilize:
- **Shape**: `AppTokens.radiusPill` (fully rounded ends).
- **Elevation**: Subtle soft shadow matching `AppTokens.primaryOliveDark` with 15% opacity.
- **Interaction**: Press scaling behavior scaling down slightly (`0.97`) to indicate physical depth.

### Cards & Surfaces
Use `AppCard` rather than custom containers.
- **Radius**: `AppTokens.radiusCard` (16px) or `AppTokens.radiusSmall` (8px).
- **Elevation**: Use `AppTokens.elevatedShadow`. Never use hard black or gray shadows.

### Widgets
- **`AppSkeleton`**: Use this instead of custom `Container` blocks for loading states. It automatically inherits the precise `shimmerBase` and `shimmerHighlight` loops.
- **`AppEmptyState`**: For empty lists or empty feature views, use this component to enforce standard, minimal illustration patterns.

## 5. Motion System
Motion should be snappy, intentional, and not overbearing.
- **Short (120ms)**: Micro-interactions like button presses, card tap scales.
- **Medium (200ms)**: Modals and bottom sheets entering the screen.
- **Long (220ms)**: Page transitions using fade + 12px upward slide. Curve: `Curves.easeOut`.
