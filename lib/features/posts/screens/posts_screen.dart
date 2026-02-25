import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/localization/localization_provider.dart';
import '../providers/posts_provider.dart';
import '../widgets/post_card.dart';
import '../../post_creation/widgets/content_creator_modal.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationProvider>();
    final postsProvider = context.watch<PostsProvider>();
    final posts = postsProvider.posts;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        // ── Create New Post header area ──
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.spacingLg,
              AppTokens.spacingLg,
              AppTokens.spacingLg,
              AppTokens.spacingSm,
            ),
            child: GestureDetector(
              onTap: () => ContentCreatorModal.show(context),
              child: Container(
                padding: const EdgeInsets.all(AppTokens.spacingLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            AppTokens.primaryOliveDark,
                            AppTokens.primaryOlive.withValues(alpha: 0.6),
                          ]
                        : [
                            AppTokens.primaryOlive,
                            AppTokens.accentGlow.withValues(alpha: 0.8),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
                  boxShadow: AppTokens.glowingShadow,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTokens.backgroundLight.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: AppTokens.backgroundLight,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: AppTokens.spacingLg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.translate('create_new_post'),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTokens.backgroundLight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            loc.translate('post_something_today'),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTokens.backgroundLight.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppTokens.backgroundLight.withValues(alpha: 0.6),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── Feed ──
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = posts[index];
                return PostCard(post: post);
              },
              childCount: posts.length,
            ),
          ),
        ),

        // bottom padding
        const SliverToBoxAdapter(
          child: SizedBox(height: AppTokens.spacingXxl),
        ),
      ],
    );
  }
}
