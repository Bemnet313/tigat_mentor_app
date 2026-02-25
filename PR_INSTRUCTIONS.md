# PR Instructions

**Title**: [Design] Olive Brand Evolution - Final Polish & Asset Kit
**Base Branch**: `design/olive-brand-evolution`
**Compare Branch**: `design/olive-brand-evolution-finish`

## Summary of Changes
- **Color Accuracy**: Eliminated completely residual occurrences of `Colors.white`, `Colors.black`, and generic `.grey`, redirecting them structurally to strictly typed `AppTokens`.
- **Motion Polish**: Inserted `AppTapBehavior` globally enabling responsive tap compression scales (0.97x) across Hero Actions, Modals, and Cards independently.
- **Component Evolution**: Substituted ad-hoc manual skeletons globally with unified, gradient-animated `AppSkeleton` implementations.
- **Asset Integrations**: Provisioned minimal 12-icon abstract SVGs, two branding lockups, and 3 localized abstract illustrations inside `assets/brand/`.
- **Code Cleanliness**: Achieved a 100% compliant `flutter analyze` run with `0 warnings`.

## Reviewer Notes
- Please insert the required **Before/After Screenshots** below prior to approving the merge!
- **Dashboard Screen**: [Insert Screenshots]
- **Wallet Screen**: [Insert Screenshots]
- **Courses Screen**: [Insert Screenshots]
- **Students Screen**: [Insert Screenshots]
- **Profile Screen**: [Insert Screenshots]
- **Community Screen**: [Insert Screenshots]

No business logic, networking layers, or router state structures were manipulated during this final visual audit pass.
