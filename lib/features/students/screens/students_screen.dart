import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../../core/widgets/app_empty_state.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  bool _isLoading = true;

  final List<String> _filters = ['All', 'Paid Students', 'Course Buyers'];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        _buildFilterChips(context),
        const Divider(),
        Expanded(
          child: _isLoading ? _buildSkeletonList() : _buildStudentsList(context),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      child: AppTextField(
        controller: TextEditingController(text: _searchQuery),
        labelText: '',
        hintText: 'Search by name or phone...',
        prefixIcon: Icons.search,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
      ),
    );
  }

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
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: AppTokens.primaryOlive.withValues(alpha: 0.2),
              checkmarkColor: AppTokens.primaryOlive,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
              ),
              side: BorderSide(
                color: isSelected ? AppTokens.primaryOlive : AppTokens.textSecondary.withValues(alpha: 0.2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const AppCard(
          padding: EdgeInsets.symmetric(horizontal: AppTokens.spacingLg, vertical: 12),
          child: Row(
            children: [
              AppSkeleton(
                width: 44,
                height: 44,
                borderRadius: 22,
              ),
              SizedBox(width: AppTokens.spacingLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: 120, height: 14),
                    SizedBox(height: 8),
                    AppSkeleton(width: 80, height: 12),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStudentsList(BuildContext context) {
    // Basic mock filtering logic based entirely on UI queries
    final filteredList = MockData.students.where((student) {
      final nameMatches = student['name'].toString().toLowerCase().contains(_searchQuery);
      return nameMatches; // Add complex filter dummy logic here if necessary
    }).toList();

    if (filteredList.isEmpty) {
      return const AppEmptyState(
        title: 'No students found',
        subtitle: 'Try adjusting your search filters.',
        icon: Icons.school,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final st = filteredList[index];
        final bool isActive = st['status'] == 'Active';
        final BadgeType type = isActive ? BadgeType.positive : BadgeType.neutral;

        return AppCard(
          padding: EdgeInsets.zero,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg, vertical: 8),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTokens.primaryOlive.withValues(alpha: 0.3), width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(st['avatar']),
                radius: 22,
              ),
            ),
            title: Text(st['name'], style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(st['course'], style: const TextStyle(color: AppTokens.textSecondary, fontSize: 13)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatusBadge(label: st['status'], type: type),
                const SizedBox(width: AppTokens.spacingSm),
                PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.surface,
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$value user ${st['name']}')),
                    );
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Block',
                      child: Text('Block User', style: TextStyle(color: AppTokens.statusRed)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Remove',
                      child: Text('Remove from Course', style: TextStyle(color: AppTokens.statusWarning)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
