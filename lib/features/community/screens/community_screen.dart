import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/theme/theme.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomThreadsCounter(context),
            const SizedBox(height: AppTheme.spacingLg),
            Text(
              'Default Rooms',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            _buildRoomCard(context, loc.translate('general'), Icons.public, 1250),
            _buildRoomCard(context, loc.translate('ask_mentor'), Icons.question_answer, 420),
            _buildRoomCard(context, loc.translate('announcements'), Icons.campaign, 850),
            const SizedBox(height: AppTheme.spacingLg),
            Text(
              'Custom Paid Rooms',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            _buildRoomCard(context, 'Premium Signals', Icons.lock, 125, isPremium: true),
            _buildRoomCard(context, '1-on-1 Coaching Logs', Icons.lock, 12, isPremium: true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUpgradeDialog(context);
        },
        backgroundColor: AppTheme.primaryStatusGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCustomThreadsCounter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.layeredShadow,
        border: Border.all(color: AppTheme.primaryStatusGreen.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.forum, color: AppTheme.primaryStatusGreen),
              const SizedBox(width: AppTheme.spacingSm),
              Text('Custom Threads Used', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Text(
            '3/5',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryStatusGreen,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, String title, IconData icon, int members, {bool isPremium = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.layeredShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigate to specific thread view inside the room
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingSm),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isPremium ? AppTheme.statusWarning.withValues(alpha: 0.1) : AppTheme.primaryStatusGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: isPremium ? AppTheme.statusWarning : AppTheme.primaryStatusGreen, size: 24),
                ),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('$members Members', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
                if (isPremium) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.statusWarning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Premium',
                      style: TextStyle(color: AppTheme.statusWarning, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                const Icon(Icons.chevron_right, color: AppTheme.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Upgrade Required'),
          content: const Text('You have used 3/5 custom threads. Upgrade to Mentor Premium (Coming Soon) to unlock unlimited threads.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close', style: TextStyle(color: AppTheme.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.statusWarning),
              child: const Text('Upgrade'),
            ),
          ],
        );
      },
    );
  }
}
