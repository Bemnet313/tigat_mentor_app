import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../post_creation/widgets/content_creator_modal.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationProvider>();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRevenueGraph(context, loc),
          const SizedBox(height: AppTheme.spacingLg),
          _buildKPIGrid(context, loc),
          const SizedBox(height: AppTheme.spacingLg),
          _buildQuickActionsRow(context, loc),
        ],
      ),
    );
  }

  Widget _buildKPIGrid(BuildContext context, LocalizationProvider loc) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppTheme.spacingMd,
      mainAxisSpacing: AppTheme.spacingMd,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      children: [
        _buildKPICard(context, loc.translate('earnings'), '${MockData.currentMonthEarningsETB} ETB', Icons.account_balance_wallet, AppTheme.primaryStatusGreen),
        _buildKPICard(context, loc.translate('active_students'), '${MockData.activeStudents}', Icons.school, Colors.blue),
        _buildKPICard(context, loc.translate('new_followers'), '+${MockData.newFollowersMonthly}', Icons.favorite, Colors.pink),
        _buildKPICard(context, loc.translate('pending_withdrawals'), '${MockData.pendingWithdrawalsETB} ETB', Icons.pending_actions, AppTheme.statusWarning),
      ],
    );
  }

  Widget _buildKPICard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.layeredShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: AppTheme.spacingSm),
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
      ),
    );
  }

  Widget _buildRevenueGraph(BuildContext context, LocalizationProvider loc) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.layeredShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Revenue Overview', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: DropdownButton<String>(
                    value: 'Jan',
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {},
                    items: <String>['Jan', 'Feb', 'Mar']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '\$4,200',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700, 
                    color: AppTheme.textPrimary, 
                    fontSize: 32,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Text(
                  'total revenue',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.electricEmerald, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingLg),
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
                        color: AppTheme.surfaceLight,
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
                          const style = TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w600, fontSize: 12);
                          Widget text;
                          switch (value.toInt()) {
                            case 1:
                              text = const Text('W1', style: style);
                              break;
                            case 3:
                              text = const Text('W2', style: style);
                              break;
                            case 5:
                              text = const Text('W3', style: style);
                              break;
                            case 7:
                               text = const Text('W4', style: style);
                               break;
                            default:
                              text = const Text('', style: style);
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: text,
                          );
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
                      color: AppTheme.electricEmerald, // Electric Emerald
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.electricEmerald.withValues(alpha: 0.15),
                            AppTheme.electricEmerald.withValues(alpha: 0.0),
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
          'Post something Today !',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppTheme.spacingMd),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: FilledButton.icon(
            onPressed: () {
              ContentCreatorModal.show(context);
            },
            icon: const Icon(Icons.add, size: 24),
            label: Text(
              loc.translate('new_post'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryStatusGreen,
              foregroundColor: AppTheme.surfaceWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
            ),
          ),
        ),
      ],
    );
  }
}
