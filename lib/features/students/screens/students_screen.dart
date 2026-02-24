import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/mock_data/mock_data.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Paid Students', 'Course Buyers'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        _buildFilterChips(context),
        const Divider(),
        Expanded(
          child: _buildStudentsList(context),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by name or phone...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: AppTheme.backgroundLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusInput),
            borderSide: BorderSide.none,
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacingSm),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              selectedColor: AppTheme.primaryStatusGreen.withValues(alpha: 0.2),
              checkmarkColor: AppTheme.primaryStatusGreen,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStudentsList(BuildContext context) {
    // Basic mock filtering logic based entirely on UI queries
    final filteredList = MockData.students.where((student) {
      final nameMatches = student['name'].toString().toLowerCase().contains(_searchQuery);
      return nameMatches; // Add complex filter dummy logic here if necessary
    }).toList();

    if (filteredList.isEmpty) {
      return Center(
         child: Text('No students found', style: Theme.of(context).textTheme.bodyMedium),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final st = filteredList[index];
        final bool isActive = st['status'] == 'Active';
        final Color statusColor = isActive ? AppTheme.primaryStatusGreen : AppTheme.textTertiary;

        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppTheme.layeredShadow,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd, vertical: 8),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryStatusGreen.withValues(alpha: 0.3), width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(st['avatar']),
                radius: 22,
              ),
            ),
            title: Text(st['name'], style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(st['course'], style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    st['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Mock Actions
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$value user ${st['name']}')),
                    );
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Block',
                      child: Text('Block User', style: TextStyle(color: AppTheme.statusRed)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Remove',
                      child: Text('Remove from Room', style: TextStyle(color: AppTheme.statusWarning)),
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
