import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';

import '../../../core/widgets/app_skeleton.dart';
import '../../../core/widgets/app_empty_state.dart';

// ─── Constants ───
const double _kCardRadius = 20.0;

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();

  /// Called from AppScaffold when the Export icon is tapped.
  static void showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => _ComingSoonDialog(
        icon: Icons.file_download_outlined,
        title: 'Export Report',
        body: 'Exporting to PDF/Excel is coming in V4!\nGet ready for full accounting.',
      ),
    );
  }
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  bool _isLoading = true;
  final Set<int> _expandedIndices = {};

  final List<String> _filters = ['All', 'Subscribers', 'Course Buyers'];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  // ─── Helpers ───
  List<Map<String, dynamic>> get _filteredStudents {
    return MockData.students.where((s) {
      // Search
      final q = _searchQuery;
      if (q.isNotEmpty) {
        final name = s['name'].toString().toLowerCase();
        final phone = (s['phone'] ?? '').toString().toLowerCase();
        if (!name.contains(q) && !phone.contains(q)) return false;
      }
      // Filter
      final type = s['type'] as String;
      if (_selectedFilter == 'Subscribers') {
        return type == 'subscriber' || type == 'both';
      } else if (_selectedFilter == 'Course Buyers') {
        return type == 'buyer' || type == 'both';
      }
      return true;
    }).toList();
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kCardRadius)),
        backgroundColor: AppTokens.primaryOlive,
      ),
    );
  }

  void _showComingSoon(String feature) {
    showDialog(
      context: context,
      builder: (_) => _ComingSoonDialog(
        icon: Icons.chat_bubble_outline_rounded,
        title: feature,
        body: '$feature is coming in V4!\nStay tuned for direct student messaging.',
      ),
    );
  }

  // ─── Build ───
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        _buildFilterChips(context),
        const SizedBox(height: 4),
        Expanded(
          child: _isLoading ? _buildSkeletonList() : _buildStudentsList(context),
        ),
      ],
    );
  }

  // ─── Search ───
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppTokens.spacingLg, AppTokens.spacingLg, AppTokens.spacingLg, AppTokens.spacingSm),
      child: AppTextField(
        controller: TextEditingController(text: _searchQuery),
        labelText: '',
        hintText: 'Search by name or phone…',
        prefixIcon: Icons.search,
        onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
      ),
    );
  }

  // ─── Filters ───
  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: AppTokens.spacingSm),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedFilter = filter),
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: AppTokens.primaryOlive.withValues(alpha: 0.2),
              checkmarkColor: AppTokens.primaryOlive,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
              ),
              side: BorderSide(
                color: isSelected
                    ? AppTokens.primaryOlive
                    : AppTokens.textSecondary.withValues(alpha: 0.2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ─── Skeleton ───
  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      itemCount: 6,
      itemBuilder: (context, index) {
        return AppCard(
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg, vertical: 14),
          child: const Row(
            children: [
              AppSkeleton(width: 44, height: 44, borderRadius: 22),
              SizedBox(width: AppTokens.spacingLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: 130, height: 14),
                    SizedBox(height: 8),
                    AppSkeleton(width: 90, height: 12),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── List ───
  Widget _buildStudentsList(BuildContext context) {
    final list = _filteredStudents;

    if (list.isEmpty) {
      return const AppEmptyState(
        title: 'No students found',
        subtitle: 'Try adjusting your search or filters.',
        icon: Icons.school,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final st = list[index];
        final isExpanded = _expandedIndices.contains(index);
        return _StudentTile(
          student: st,
          isExpanded: isExpanded,
          onToggle: () => setState(() {
            if (isExpanded) {
              _expandedIndices.remove(index);
            } else {
              _expandedIndices.add(index);
            }
          }),
          onCopy: _copyToClipboard,
          onAction: _showComingSoon,
        );
      },
    );
  }
}

// ═════════════════════════════════════════════════════════════════
//  STUDENT TILE — collapsed + expanded
// ═════════════════════════════════════════════════════════════════
class _StudentTile extends StatelessWidget {
  final Map<String, dynamic> student;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function(String text, String label) onCopy;
  final void Function(String feature) onAction;

  const _StudentTile({
    required this.student,
    required this.isExpanded,
    required this.onToggle,
    required this.onCopy,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final type = student['type'] as String;
    final subStatus = student['subStatus'] as String?;
    final courses = (student['courses'] as List?) ?? [];
    final isSubscriber = type == 'subscriber' || type == 'both';
    final isBuyer = type == 'buyer' || type == 'both';

    return Container(
      margin: const EdgeInsets.only(bottom: AppTokens.spacingLg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? [const BoxShadow(color: AppTokens.overlayDark, blurRadius: 10, offset: Offset(0, 4))]
            : AppTokens.elevatedShadow,
        border: Theme.of(context).brightness == Brightness.dark
            ? Border.all(color: AppTokens.primaryOlive.withValues(alpha: 0.2), width: 1.2)
            : null,
      ),
      child: Column(
        children: [
          // ── Collapsed Row ──
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(_kCardRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg, vertical: 14),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTokens.primaryOlive.withValues(alpha: 0.3), width: 2),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(student['avatar']),
                      radius: 22,
                    ),
                  ),
                  const SizedBox(width: AppTokens.spacingMd),
                  // Name + badges
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Status dot for subscribers
                            if (isSubscriber && subStatus != null) ...[
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _statusDotColor(subStatus),
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                            Flexible(
                              child: Text(
                                student['name'],
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Badges row
                        Row(
                          children: [
                            if (isSubscriber)
                              _MiniTag(label: 'Sub', color: AppTokens.primaryOlive),
                            if (isSubscriber && isBuyer)
                              const SizedBox(width: 6),
                            if (isBuyer)
                              _MiniTag(label: 'Buyer', color: AppTokens.statusWarning),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Chevron
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0,
                    duration: AppTokens.durationMedium,
                    child: const Icon(Icons.chevron_right, color: AppTokens.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          // ── Expanded Sections ──
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildExpanded(context, isSubscriber, isBuyer, subStatus, courses),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: AppTokens.durationMedium,
          ),
        ],
      ),
    );
  }

  Color _statusDotColor(String? status) {
    switch (status) {
      case 'paid':
        return AppTokens.primaryOlive;
      case 'pending':
        return AppTokens.statusWarning;
      case 'expired':
        return AppTokens.statusRed;
      default:
        return AppTokens.textTertiary;
    }
  }

  Widget _buildExpanded(BuildContext ctx, bool isSub, bool isBuy, String? subStatus, List courses) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppTokens.spacingLg, 0, AppTokens.spacingLg, AppTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: AppTokens.spacingMd),

          // ── Section A: Contact ──
          _SectionHeader(title: 'Contact'),
          const SizedBox(height: 8),
          _ContactRow(icon: Icons.phone_outlined, text: student['phone'] ?? '—', onCopy: () => onCopy(student['phone'] ?? '', 'Phone')),
          const SizedBox(height: 6),
          _ContactRow(icon: Icons.email_outlined, text: student['email'] ?? '—', onCopy: () => onCopy(student['email'] ?? '', 'Email')),
          const SizedBox(height: AppTokens.spacingLg),

          // ── Section B: Financials ──
          _SectionHeader(title: 'Financials'),
          const SizedBox(height: 8),
          _InfoPill(
            label: isBuy ? 'Enrollment Date' : 'Joined Date',
            value: student['joinedDate'] ?? '—',
          ),
          const SizedBox(height: 6),
          _InfoPill(
            label: 'Price Paid',
            value: '${student['pricePaid'] ?? 0} ETB',
          ),
          if (isSub && subStatus != null) ...[
            const SizedBox(height: 6),
            _InfoPill(
              label: 'Status',
              value: subStatus[0].toUpperCase() + subStatus.substring(1),
              valueColor: _statusDotColor(subStatus),
            ),
          ],
          const SizedBox(height: AppTokens.spacingLg),

          // ── Section C: Course Progress ──
          if (courses.isNotEmpty) ...[
            _SectionHeader(title: 'Course Progress'),
            const SizedBox(height: 8),
            ...courses.map<Widget>((c) {
              final progress = (c['progress'] as num).toDouble();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            c['name'],
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Theme.of(ctx).textTheme.bodyMedium?.color),
                          ),
                        ),
                        Text(
                          '${(progress * 100).round()}%',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTokens.primaryOlive),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 7,
                        backgroundColor: AppTokens.primaryOlive.withValues(alpha: 0.12),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTokens.primaryOlive),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 4),
          ],

          // ── Section D: Actions ──
          Row(
            children: [
              Expanded(
                child: _OliveButton(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Message',
                  onTap: () => onAction('Message'),
                ),
              ),
              const SizedBox(width: AppTokens.spacingSm),
              Expanded(
                child: _OliveButton(
                  icon: Icons.notifications_active_outlined,
                  label: 'Send Reminder',
                  onTap: () => onAction('Send Reminder'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════
//  SMALL REUSABLE WIDGETS
// ═════════════════════════════════════════════════════════════════

class _MiniTag extends StatelessWidget {
  final String label;
  final Color color;
  const _MiniTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
        color: AppTokens.primaryOlive,
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onCopy;
  const _ContactRow({required this.icon, required this.text, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTokens.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13, color: AppTokens.textSecondary)),
        ),
        InkWell(
          onTap: onCopy,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.copy_rounded, size: 16, color: AppTokens.primaryOlive),
          ),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _InfoPill({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: ', style: const TextStyle(fontSize: 12, color: AppTokens.textTertiary)),
        Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: valueColor ?? Theme.of(context).textTheme.bodyMedium?.color)),
      ],
    );
  }
}

class _OliveButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _OliveButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTokens.primaryOlive.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(_kCardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kCardRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: AppTokens.primaryOlive),
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTokens.primaryOlive)),
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════
//  PREMIUM "COMING SOON" DIALOG
// ═════════════════════════════════════════════════════════════════
class _ComingSoonDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _ComingSoonDialog({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kCardRadius)),
      child: Container(
        padding: const EdgeInsets.all(AppTokens.spacingXl),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_kCardRadius),
          color: AppTokens.primaryOlive.withValues(alpha: 0.06),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTokens.primaryOlive.withValues(alpha: 0.15),
              ),
              child: Icon(icon, color: AppTokens.primaryOlive, size: 28),
            ),
            const SizedBox(height: AppTokens.spacingLg),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTokens.primaryOlive),
            ),
            const SizedBox(height: AppTokens.spacingSm),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: AppTokens.textSecondary, height: 1.5),
            ),
            const SizedBox(height: AppTokens.spacingXl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTokens.primaryOlive,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kCardRadius)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Got it!', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
