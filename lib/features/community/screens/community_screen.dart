import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/widgets/app_card.dart';
import '../widgets/create_room_modal.dart';

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
            _buildRoomCard(context, loc.translate('general'), Icons.public, 1250, id: 'general'),
            _buildRoomCard(context, 'Ask Senai', Icons.question_answer, 420, id: 'ask_senai'),
            const SizedBox(height: AppTokens.spacingLg),
            Text(
              'Custom Rooms',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppTokens.spacingSm),
            _buildRoomCard(context, 'Quizzes', Icons.quiz, 125, id: 'quizzes'),
            _buildRoomCard(context, 'Weekly Prep', Icons.calendar_today, 12, id: 'weekly'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateRoomModal(context);
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
              Text('Custom Rooms Used', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Text(
            '2/5',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTokens.primaryOlive,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, String title, IconData icon, int members, {required String id, bool isPremium = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTokens.spacingMd),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          onTap: () {
            context.push('/community/$id');
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

  void _showCreateRoomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateRoomModal(),
    );
  }
}
