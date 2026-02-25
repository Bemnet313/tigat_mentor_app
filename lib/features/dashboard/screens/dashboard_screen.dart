import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/motion.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../post_creation/widgets/content_creator_modal.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationProvider>();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRevenueGraph(context, loc),
          const SizedBox(height: AppTokens.spacingXl),
          _buildKPIGrid(context, loc),
          const SizedBox(height: AppTokens.spacingXl),
          _buildQuickActionsRow(context, loc),
        ],
      ),
    );
  }

  Widget _buildKPIGrid(BuildContext context, LocalizationProvider loc) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppTokens.spacingLg,
      mainAxisSpacing: AppTokens.spacingLg,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: [
        _buildKPICard(context, loc.translate('earnings'), '${MockData.currentMonthEarningsETB} ETB', Icons.account_balance_wallet, AppTokens.primaryOlive),
        // ── Active Students: warm, clickable card ──
        _buildActiveStudentsCard(context, loc),
        _buildKPICard(context, loc.translate('new_followers'), '+${MockData.newFollowersMonthly}', Icons.favorite, AppTokens.statusWarning),
        _buildKPICard(context, loc.translate('pending_withdrawals'), '${MockData.pendingWithdrawalsETB} ETB', Icons.pending_actions, AppTokens.statusRed),
      ],
    );
  }

  /// Special warm & clickable card for "Active Students"
  Widget _buildActiveStudentsCard(BuildContext context, LocalizationProvider loc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => context.go('/students'),
      child: AppCard(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTokens.radiusCard),
            color: isDark
                ? AppTokens.primaryOlive.withValues(alpha: 0.08)
                : AppTokens.primaryOlive.withValues(alpha: 0.05),
          ),
          padding: const EdgeInsets.all(AppTokens.spacingMd),
          child: Stack(
            children: [
              // Chevron top-right for interactivity hint
              Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: AppTokens.accentGlow.withValues(alpha: 0.7),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.school, size: 20, color: AppTokens.accentGlow),
                      const SizedBox(width: AppTokens.spacingSm),
                      Expanded(
                        child: Text(
                          loc.translate('active_students'),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${MockData.activeStudents}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKPICard(BuildContext context, String title, String value, IconData icon, Color color) {
    return AppCard(
      padding: const EdgeInsets.all(AppTokens.spacingMd),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: AppTokens.spacingSm),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueGraph(BuildContext context, LocalizationProvider loc) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppTokens.primaryOliveDark, 
            AppTokens.primaryOlive,
            AppTokens.accentSoft,
          ],
          stops: [0.0, 0.7, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        boxShadow: AppTokens.glowingShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.translate('revenue_overview'), 
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTokens.backgroundLight, fontWeight: FontWeight.bold)
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTokens.overlayLight,
                    borderRadius: BorderRadius.circular(AppTokens.radiusPill),
                  ),
                  child: DropdownButton<String>(
                    value: 'Jan',
                    dropdownColor: AppTokens.primaryOliveDark,
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: AppTokens.backgroundLight),
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {},
                    items: <String>['Jan', 'Feb', 'Mar']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: AppTokens.backgroundLight, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.spacingLg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${MockData.currentMonthEarningsETB}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700, 
                    color: AppTokens.backgroundLight,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: AppTokens.spacingXs),
                Text(
                  'ETB',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700, 
                    color: AppTokens.backgroundLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.spacingXl),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: AppTokens.overlayLight,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(color: AppTokens.textTertiary, fontWeight: FontWeight.w600, fontSize: 12);
                          Widget text;
                          switch (value.toInt()) {
                            case 1: text = const Text('W1', style: style); break;
                            case 3: text = const Text('W2', style: style); break;
                            case 5: text = const Text('W3', style: style); break;
                            case 7: text = const Text('W4', style: style); break;
                            default: text = const Text('', style: style); break;
                          }
                          return SideTitleWidget(axisSide: meta.axisSide, child: text);
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 8,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1000),
                        FlSpot(2, 2000),
                        FlSpot(4, 1500),
                        FlSpot(7, 3000),
                      ],
                      isCurved: true,
                      color: AppTokens.accentGlow,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppTokens.accentGlow.withValues(alpha: 0.3),
                            AppTokens.accentGlow.withValues(alpha: 0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsRow(BuildContext context, LocalizationProvider loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.translate('post_something_today'),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppTokens.spacingLg),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: AppTapBehavior(
            child: FilledButton.icon(
              onPressed: () {
              ContentCreatorModal.show(context);
            },
            icon: const Icon(Icons.add, size: 24),
            label: Text(
              loc.translate('new_post'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ),
          ),
        ),
      ],
    );
  }
}
