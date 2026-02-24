import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../../core/design/tokens.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/app_text_field.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBalanceCard(context),
          Padding(
            padding: const EdgeInsets.all(AppTokens.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBankDetailsCard(context),
                const SizedBox(height: AppTokens.spacingLg),
                Text(
                  'Withdrawal History',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppTokens.spacingLg),
                _isLoading ? _buildHistorySkeleton() : _buildHistoryList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(AppTokens.spacingXl, AppTokens.spacingXl, AppTokens.spacingXl, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTokens.primaryOliveDark,
            AppTokens.primaryOlive,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Withdrawable Balance',
            style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTokens.spacingSm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${MockData.currentMonthEarningsETB}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: AppTokens.spacingSm),
              Text(
                'ETB',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingXl),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTokens.radiusCard),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 0.5,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _showWithdrawModal(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          'Request Withdrawal',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsCard(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTokens.primaryOlive.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_balance, color: AppTokens.primaryOlive, size: 28),
          ),
          const SizedBox(width: AppTokens.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bank Account', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(MockData.bankAccount, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  'Contact admin to update account.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySkeleton() {
    return Column(
      children: List.generate(3, (index) => _buildSkeletonItem()),
    );
  }

  Widget _buildSkeletonItem() {
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTokens.textSecondary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppTokens.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 14,
                  color: AppTokens.textSecondary.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 12,
                  color: AppTokens.textSecondary.withValues(alpha: 0.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: MockData.withdrawals.length,
      itemBuilder: (context, index) {
        final w = MockData.withdrawals[index];

        BadgeType type = BadgeType.warning;
        if (w['status'] == 'Completed') type = BadgeType.positive;
        if (w['status'] == 'Rejected') type = BadgeType.negative;

        return AppCard(
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingMd, vertical: AppTokens.spacingSm),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              w['status'] == 'Completed' ? Icons.check_circle : (w['status'] == 'Rejected' ? Icons.cancel : Icons.pending),
              color: type == BadgeType.positive ? AppTokens.primaryOlive : (type == BadgeType.negative ? AppTokens.statusRed : AppTokens.statusWarning),
            ),
            title: Text(w['amount'], style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(w['date'], style: Theme.of(context).textTheme.bodySmall),
            trailing: StatusBadge(label: w['status'], type: type),
          ),
        );
      },
    );
  }

  void _showWithdrawModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTokens.radiusLarge)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: AppTokens.spacingLg,
            right: AppTokens.spacingLg,
            top: AppTokens.spacingXxl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Request Withdrawal', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppTokens.spacingXl),
              const AppTextField(
                labelText: 'Amount (ETB)',
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppTokens.spacingXl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Withdrawal Request Submitted')),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppTokens.spacingLg),
                    child: Text('Confirm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: AppTokens.spacingXl),
            ],
          ),
        );
      },
    );
  }
}
