import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/status_badge.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
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
                labelColor: AppTokens.primaryOlive,
                unselectedLabelColor: AppTokens.textSecondary,
                indicatorColor: AppTokens.primaryOlive,
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
                  _buildCoursesGrid(context, 'Published'),
                  _buildCoursesGrid(context, 'Draft'),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create Course Flow')));
          },
          backgroundColor: AppTokens.primaryOlive,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCoursesGrid(BuildContext context, String filterStatus) {
    final filtered = MockData.courses.where((c) => c['status'] == filterStatus).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library, size: 60, color: AppTokens.textSecondary.withValues(alpha: 0.3)),
            const SizedBox(height: AppTokens.spacingMd),
            Text('No courses found', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTokens.textSecondary)),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppTokens.spacingMd),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppTokens.spacingMd,
        mainAxisSpacing: AppTokens.spacingMd,
        childAspectRatio: 0.75,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final course = filtered[index];
        final bool isPublished = filterStatus == 'Published';
        final double progress = index % 2 == 0 ? 0.8 : 0.35;

        return AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTokens.radiusCard)),
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/seed/${course['title'].hashCode}/400/300',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: AppTokens.textSecondary.withValues(alpha: 0.1)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppTokens.spacingSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['title'],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppTokens.spacingXs),
                      Text(
                        '${course['price']}',
                        style: const TextStyle(color: AppTokens.primaryOlive, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if (isPublished) ...[
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: AppTokens.primaryOlive.withValues(alpha: 0.2),
                                  color: AppTokens.primaryOlive,
                                  minHeight: 4,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppTokens.spacingXs),
                            Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTokens.primaryOlive)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
