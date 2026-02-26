import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';

/// A video library picker specifically for the Post Creation flow.
/// Mirrors the General Room video picker but uses the Olive theme with
/// 20px rounded corners on all thumbnails.
class PostVideoLibraryPicker extends StatelessWidget {
  const PostVideoLibraryPicker({super.key});

  /// Shows the picker and returns the selected video map (or null).
  static Future<Map<String, dynamic>?> show(BuildContext context) {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PostVideoLibraryPicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? Theme.of(context).colorScheme.surface
        : AppTokens.backgroundLight;

    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTokens.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTokens.primaryOlive.withValues(alpha: 0.12),
            blurRadius: 32,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHandleAndHeader(context),
          _buildDivider(),
          Expanded(child: _buildVideoGrid(context)),
        ],
      ),
    );
  }

  Widget _buildHandleAndHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppTokens.spacingLg, AppTokens.spacingMd, AppTokens.spacingMd, 0),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppTokens.spacingLg),
              decoration: BoxDecoration(
                color: AppTokens.textTertiary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTokens.primaryOlive, Color(0xFF6B7E30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.video_library_rounded,
                    color: Theme.of(context).colorScheme.onPrimary, size: 20),
              ),
              const SizedBox(width: AppTokens.spacingMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick from Library',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Select a published course video',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppTokens.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context, null),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingMd),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1);
  }

  Widget _buildVideoGrid(BuildContext context) {
    final videos = MockData.publishedVideos;
    return GridView.builder(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppTokens.spacingMd,
        mainAxisSpacing: AppTokens.spacingMd,
        childAspectRatio: 0.78,
      ),
      itemCount: videos.length,
      itemBuilder: (ctx, index) => _VideoCard(
        video: videos[index],
        onTap: () => Navigator.pop(context, videos[index]),
      ),
    );
  }
}

class _VideoCard extends StatefulWidget {
  final Map<String, dynamic> video;
  final VoidCallback onTap;

  const _VideoCard({required this.video, required this.onTap});

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: AppTokens.durationShort,
    );
    _scaleAnim =
        Tween<double>(begin: 1.0, end: 0.96).animate(_scaleController);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (ctx, child) =>
            Transform.scale(scale: _scaleAnim.value, child: child),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? Theme.of(context).colorScheme.surface
                : AppTokens.backgroundLight,
            borderRadius: BorderRadius.circular(20), // 20px as specified
            boxShadow: AppTokens.elevatedShadow,
            border: isDark
                ? Border.all(
                    color: AppTokens.primaryOlive.withValues(alpha: 0.2),
                    width: 1)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Thumbnail
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        video['thumbnail'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppTokens.surfaceElevated,
                          child: const Icon(Icons.broken_image,
                              color: AppTokens.textTertiary, size: 40),
                        ),
                      ),
                      // Olive gradient overlay at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                AppTokens.primaryOliveDark
                                    .withValues(alpha: 0.7),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      // Play button
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5)),
                          ),
                          child: Icon(Icons.play_arrow_rounded,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      // Duration badge (bottom-right)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTokens.primaryOliveDark
                                .withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            video['duration'] as String,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.all(AppTokens.spacingMd),
                child: Text(
                  video['title'] as String,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
