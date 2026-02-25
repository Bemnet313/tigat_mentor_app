import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/widgets/app_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomThreadsCounter(context),
            const SizedBox(height: AppTokens.spacingLg),
            Text(
              'Default Rooms',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppTokens.spacingSm),
            _buildRoomCard(context, loc.translate('general'), Icons.public, 1250),
            _buildRoomCard(context, loc.translate('ask_mentor'), Icons.question_answer, 420),
            _buildRoomCard(context, loc.translate('announcements'), Icons.campaign, 850),
            const SizedBox(height: AppTokens.spacingLg),
            Text(
              'Custom Paid Rooms',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppTokens.spacingSm),
            _buildRoomCard(context, 'Premium Signals', Icons.lock, 125, isPremium: true),
            _buildRoomCard(context, '1-on-1 Coaching Logs', Icons.lock, 12, isPremium: true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUpgradeDialog(context);
        },
        backgroundColor: AppTokens.primaryOlive,
        child: const Icon(Icons.add, color: AppTokens.backgroundLight),
      ),
    );
  }

  Widget _buildCustomThreadsCounter(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.forum, color: AppTokens.primaryOlive),
              const SizedBox(width: AppTokens.spacingSm),
              Text('Custom Threads Used', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Text(
            '3/5',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTokens.primaryOlive,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, String title, IconData icon, int members, {bool isPremium = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTokens.spacingMd),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          onTap: () {
            // Navigate to specific thread view inside the room
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingMd, vertical: AppTokens.spacingSm),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isPremium ? AppTokens.statusWarning.withValues(alpha: 0.1) : AppTokens.primaryOlive.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: isPremium ? AppTokens.statusWarning : AppTokens.primaryOlive, size: 24),
                ),
                const SizedBox(width: AppTokens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('$members Members', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTokens.textSecondary)),
                    ],
                  ),
                ),
                if (isPremium) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTokens.statusWarning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Premium',
                      style: TextStyle(color: AppTokens.statusWarning, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                const Icon(Icons.chevron_right, color: AppTokens.textTertiary),
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
              child: const Text('Close', style: TextStyle(color: AppTokens.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(backgroundColor: AppTokens.statusWarning),
              child: const Text('Upgrade'),
            ),
          ],
        );
      },
    );
  }
}
