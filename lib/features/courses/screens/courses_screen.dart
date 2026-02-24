import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../core/mock_data/mock_data.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const TabBar(
                labelColor: AppTheme.primaryStatusGreen,
                unselectedLabelColor: AppTheme.textSecondary,
                indicatorColor: AppTheme.primaryStatusGreen,
                indicatorSize: TabBarIndicatorSize.label,
                dividerHeight: 0,
                tabs: [
                  Tab(text: 'Published'),
                  Tab(text: 'Drafts'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildCoursesList(context, 'Published'),
                  _buildCoursesList(context, 'Draft'),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create Course Flow')));
          },
          backgroundColor: AppTheme.primaryStatusGreen,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context, String filterStatus) {
    final filtered = MockData.courses.where((c) => c['status'] == filterStatus).toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('No courses found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final course = filtered[index];
        final bool isPublished = filterStatus == 'Published';
        final double progress = index % 2 == 0 ? 0.8 : 0.35; // Mock progress logic

        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingLg),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  'https://picsum.photos/seed/${course['title']}/400/200',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course['title'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${course['price']} • ${course['students']} Enrolled',
                            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                          ),
                          if (isPublished) ...[
                            const SizedBox(height: AppTheme.spacingSm),
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: AppTheme.primaryStatusGreen.withValues(alpha: 0.2),
                                      color: AppTheme.primaryStatusGreen,
                                      minHeight: 6,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppTheme.spacingSm),
                                Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryStatusGreen)),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    IconButton(
                      icon: const Icon(Icons.edit_note, color: AppTheme.textSecondary, size: 28),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit Course Open')));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
