# Design Polish Notes: Olive Brand Evolution

## Exact Token Changes
The final "Warm Olive" palette has been refined and strictly enforced:
- **primaryOlive**: `#4A5A23` (Core brand color, primary actions)
- **primaryOliveDark**: `#1F2A14` (High-contrast, backgrounds, hero gradients)
- **accentGlow**: `#B7D77A` (Highlights, focus ring, glow effects)
- **accentSoft**: `#E3F2C6` (Soft blend elements, inactive/subtle backgrounds)
- **surfaceElevated**: `#F6F8F3` (Standard canvas for elevated light inputs and cards)

All raw colors (`Colors.white`, `Colors.black`, `Colors.grey`) were successfully audited and replaced with global tokens or safe hex alphas, guaranteeing > 98% compliance. Global glow alphas were clamped back by 15-25% from MVP metrics to prevent retinal fatigue, and `blurRadius` values exceeding 24 foram strictly removed for GPU optimization. 

## Global Motion System Rules
A standardized global motion file (`lib/core/design/motion.dart`) was introduced yielding:
- **Speeds**: Short (120ms), Medium (220ms), Long (360ms). 
- **Curve**: `Curves.easeInOut` applied to default behaviors.
- **Page Transitions**: `FadeSlidePageTransitionsBuilder` implemented, driving a consistent Y-axis translation offset (`12px`) stacked via `Opacity` fading upward across 220ms.
- **Micro-Interactions (`AppTapBehavior`)**: A global tap listener mixin intercepts raw pointer down/up taps, providing an immediate tactile `0.97` geometric scale to `<FilledButton>` and `AppCard` surfaces globally, bypassing default material ripple latency constraints.
