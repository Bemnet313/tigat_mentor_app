import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tigat_mentor_app/core/design/tokens.dart';
import 'package:tigat_mentor_app/features/courses/models/course_model.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onToggleVisibility;
  final VoidCallback? onPublish;

  const CourseCard({
    super.key,
    required this.course,
    required this.onEdit,
    required this.onDelete,
    this.onToggleVisibility,
    this.onPublish,
  });

  @override
  Widget build(BuildContext context) {
    final isPublished = course.status == CourseStatus.published;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTokens.spacingLg),
      decoration: BoxDecoration(
        color: AppTokens.backgroundLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTokens.elevatedShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingMd),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 100,
                height: 100,
                color: AppTokens.surfaceElevated,
                child: Image.network(
                  course.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image,
                    color: AppTokens.textTertiary,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppTokens.spacingLg),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppTokens.spacingXs),
                  Text(
                    "Created on ${DateFormat('MMM dd, yyyy').format(course.createdAt)}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTokens.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppTokens.spacingXs),
                  if (isPublished)
                    Text(
                      "Students: ${course.studentCount}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTokens.textSecondary,
                          ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.spacingSm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTokens.statusWarning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                      ),
                      child: Text(
                        "Draft",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTokens.statusWarning,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  const SizedBox(height: AppTokens.spacingSm),
                  // Price Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.spacingMd,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTokens.primaryOlive,
                      borderRadius: BorderRadius.circular(AppTokens.radiusPill),
                    ),
                    child: Text(
                      "${course.price.toInt()} ETB",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Actions
            Column(
              children: [
                _ActionButton(
                  icon: Icons.edit_outlined,
                  onPressed: onEdit,
                  color: AppTokens.primaryOlive,
                ),
                if (isPublished)
                  _ActionButton(
                    icon: course.isPublic ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    onPressed: onToggleVisibility ?? () {},
                    color: AppTokens.textSecondary,
                  )
                else
                  _ActionButton(
                    icon: Icons.publish_outlined,
                    onPressed: onPublish ?? () {},
                    color: AppTokens.primaryOlive,
                  ),
                _ActionButton(
                  icon: Icons.delete_outline,
                  onPressed: onDelete,
                  color: AppTokens.statusRed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color, size: 22),
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
    );
  }
}
