# How to Revert the Olive-glow UI

If you need to roll back these changes and return to the previous "Vibe-coded" design system, follow these steps:

## Git Rollback
Switch back to the main branch and abandon these changes if they haven't been merged:
```bash
git checkout main
```

If they have been merged, revert the merge commit:
```bash
git revert -m 1 <merge_commit_sha>
```

## Manual File Restoration
If you want to keep some functional changes but revert the UI logic:

1. **Restore Theme Files:**
   The original theme settings were backed up.
   - Delete `lib/core/theme/app_theme.dart` and `lib/core/design/tokens.dart`.
   - Rename `lib/core/theme/theme_backup_....dart` back to `app_theme.dart`.
   - Rename `lib/core/theme/theme_provider_backup_....dart` back to `theme_provider.dart`.

2. **Revert Package Additions:**
   Remove `cached_network_image` from your `pubspec.yaml` and run `flutter pub get`.

3. **Revert Screen Views:**
   - In `courses_screen.dart`, revert the `GridView.builder` back to a `ListView.builder`.
   - In `app_text_field.dart`, remove the wrapping `Container` that applies the two BoxShadows (Neumorphism).

4. **Clean Build:**
   ```bash
   flutter clean
   flutter pub get
   ```
