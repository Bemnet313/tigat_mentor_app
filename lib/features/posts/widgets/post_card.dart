import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/widgets/app_card.dart';
import '../models/post_model.dart';
import '../providers/posts_provider.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTokens.spacingLg),
      child: AppCard(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: avatar, name, time, menu ──
            _buildHeader(context, isDark),

            // ── Content Area ──
            _buildContent(context, isDark),

            // ── Bottom: Reactions & Comments ──
            _buildBottomBar(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTokens.spacingLg,
        AppTokens.spacingMd,
        AppTokens.spacingSm, // less right padding so menu is near edge
        0,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(post.authorAvatarUrl),
            backgroundColor: AppTokens.surfaceElevated,
          ),
          const SizedBox(width: AppTokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.authorName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (post.isMentor) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.verified, size: 14, color: AppTokens.primaryOlive),
                    ],
                  ],
                ),
                Text(
                  post.formattedTime,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTokens.textTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Post type badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppTokens.primaryOlive.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTokens.radiusPill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(post.typeIcon, size: 12, color: AppTokens.primaryOlive),
                const SizedBox(width: 3),
                Text(
                  post.type.name[0].toUpperCase() + post.type.name.substring(1),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTokens.primaryOlive),
                ),
              ],
            ),
          ),
          // Three-dots menu
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value),
            icon: Icon(Icons.more_vert, color: AppTokens.textSecondary, size: 20),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit_outlined, size: 18), SizedBox(width: 8), Text('Edit')])),
              const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete_outline, size: 18, color: AppTokens.statusRed), SizedBox(width: 8), Text('Delete', style: TextStyle(color: AppTokens.statusRed))])),
              PopupMenuItem(value: 'hide', child: Row(children: [Icon(post.isHidden ? Icons.visibility : Icons.visibility_off_outlined, size: 18), const SizedBox(width: 8), Text(post.isHidden ? 'Make Public' : 'Hide/Private')])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTokens.spacingLg,
        AppTokens.spacingMd,
        AppTokens.spacingLg,
        AppTokens.spacingMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text content
          Text(
            post.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),

          // Image content
          if (post.type == PostType.image && post.mediaUrl != null) ...[
            const SizedBox(height: AppTokens.spacingMd),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              child: Image.network(
                post.mediaUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppTokens.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                  ),
                  child: const Center(child: Icon(Icons.image, size: 48, color: AppTokens.textTertiary)),
                ),
              ),
            ),
          ],

          // Video thumbnail
          if (post.type == PostType.video && post.mediaUrl != null) ...[
            const SizedBox(height: AppTokens.spacingMd),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                  child: Image.network(
                    post.mediaUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: AppTokens.surfaceElevated,
                      child: const Center(child: Icon(Icons.videocam, size: 48, color: AppTokens.textTertiary)),
                    ),
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTokens.primaryOlive.withValues(alpha: 0.85),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow_rounded, color: AppTokens.backgroundLight, size: 32),
                ),
              ],
            ),
          ],

          // Poll
          if (post.type == PostType.poll && post.pollOptions != null) ...[
            const SizedBox(height: AppTokens.spacingMd),
            ...post.pollOptions!.map((option) => Padding(
              padding: const EdgeInsets.only(bottom: AppTokens.spacingSm),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg, vertical: AppTokens.spacingMd),
                decoration: BoxDecoration(
                  color: isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated,
                  borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
                  border: Border.all(color: AppTokens.borderSubtle),
                ),
                child: Text(option, style: Theme.of(context).textTheme.bodyMedium),
              ),
            )),
          ],

          // Voice note placeholder
          if (post.type == PostType.voice) ...[
            const SizedBox(height: AppTokens.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppTokens.spacingMd),
              decoration: BoxDecoration(
                color: isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated,
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTokens.primaryOlive.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: AppTokens.primaryOlive),
                  ),
                  const SizedBox(width: AppTokens.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Waveform placeholder
                        Container(
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: CustomPaint(
                            painter: _WaveformPainter(
                              color: AppTokens.primaryOlive,
                              isDark: isDark,
                            ),
                            size: const Size(double.infinity, 28),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '0:42',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTokens.textTertiary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppTokens.spacingLg, 0, AppTokens.spacingLg, AppTokens.spacingMd),
      child: Row(
        children: [
          // Heart
          _buildReactionChip(context, Icons.favorite_rounded, post.reactions.hearts, const Color(0xFFFF4D6A), 'heart'),
          const SizedBox(width: AppTokens.spacingMd),
          // Thumbs up
          _buildReactionChip(context, Icons.thumb_up_rounded, post.reactions.thumbsUp, const Color(0xFF4A90D9), 'thumbsUp'),
          const SizedBox(width: AppTokens.spacingMd),
          // Fire
          _buildReactionChip(context, Icons.local_fire_department_rounded, post.reactions.fire, const Color(0xFFFF9500), 'fire'),
          const Spacer(),
          // Comments
          GestureDetector(
            onTap: () => context.push('/posts/${post.id}/comments'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTokens.primaryOlive.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppTokens.radiusPill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat_bubble_outline_rounded, size: 16, color: AppTokens.primaryOlive),
                  const SizedBox(width: 4),
                  Text(
                    '${post.comments.length}',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTokens.primaryOlive),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionChip(BuildContext context, IconData icon, int count, Color color, String type) {
    return GestureDetector(
      onTap: () => context.read<PostsProvider>().togglePostReaction(post.id, type),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 3),
          Text(
            '$count',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTokens.textSecondary),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit post (coming soon)')));
        break;
      case 'delete':
        context.read<PostsProvider>().deletePost(post.id);
        break;
      case 'hide':
        context.read<PostsProvider>().toggleHidePost(post.id);
        break;
    }
  }
}

/// Custom painter for voice note waveform visualization
class _WaveformPainter extends CustomPainter {
  final Color color;
  final bool isDark;

  _WaveformPainter({required this.color, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final barCount = 30;
    final barWidth = size.width / (barCount * 2);

    for (int i = 0; i < barCount; i++) {
      // Pseudo-waveform: sine-based variation
      final heightFraction = 0.3 + 0.7 * ((i * 7 + 3) % 11) / 11;
      final barHeight = size.height * heightFraction;
      final x = i * barWidth * 2 + barWidth;
      final y1 = (size.height - barHeight) / 2;
      final y2 = y1 + barHeight;

      canvas.drawLine(Offset(x, y1), Offset(x, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
