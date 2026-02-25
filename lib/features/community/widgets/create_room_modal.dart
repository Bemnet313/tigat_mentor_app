import 'package:flutter/material.dart';
import '../../../../core/design/tokens.dart';
import '../../../../core/widgets/app_text_field.dart';

class CreateRoomModal extends StatelessWidget {
  const CreateRoomModal({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        decoration: BoxDecoration(
          color: isDark ? AppTokens.primaryOliveDark : AppTokens.backgroundLight,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppTokens.radiusLarge),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppTokens.spacingLg),
                decoration: BoxDecoration(
                  color: AppTokens.textTertiary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Create Custom Room',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppTokens.spacingMd),
            const AppTextField(
              labelText: 'Room Name',
              hintText: 'e.g., Weekly Live Sessions',
            ),
            const SizedBox(height: AppTokens.spacingMd),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Room Access',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                ),
              ),
              initialValue: 'Free',
              items: const [
                DropdownMenuItem(value: 'Free', child: Text('Free for All Students')),
                DropdownMenuItem(value: 'Premium', child: Text('Premium Mentorship Only')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: AppTokens.spacingLg),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTokens.primaryOlive,
                foregroundColor: AppTokens.backgroundLight,
                padding: const EdgeInsets.symmetric(vertical: AppTokens.spacingMd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                ),
              ),
              child: const Text('Create Room', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
