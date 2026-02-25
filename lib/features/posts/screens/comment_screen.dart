import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/mock_data.dart';
import '../models/post_model.dart';
import '../providers/posts_provider.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? _replyToAuthor;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = context.watch<PostsProvider>();
    final post = postsProvider.posts.cast<PostModel?>().firstWhere(
      (p) => p?.id == widget.postId,
      orElse: () => null,
    );

    if (post == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Comments')),
        body: const Center(child: Text('Post not found')),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : AppTokens.surfaceElevated,
      appBar: _buildAppBar(context, post, isDark),
      body: Column(
        children: [
          // ── Comment list ──
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppTokens.spacingLg,
                AppTokens.spacingMd,
                AppTokens.spacingLg,
                AppTokens.spacingLg,
              ),
              itemCount: post.comments.length,
              itemBuilder: (context, index) {
                final comment = post.comments[index];
                return _buildCommentBubble(context, comment, post, isDark);
              },
            ),
          ),
          // ── Message input bar ──
          _buildInputBar(context, post, isDark),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, PostModel post, bool isDark) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(post.authorAvatarUrl),
          ),
          const SizedBox(width: AppTokens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.authorName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${post.comments.length} comments',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTokens.textTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  Widget _buildCommentBubble(BuildContext context, CommentModel comment, PostModel post, bool isDark) {
    final isMentor = comment.isMentor;

    return GestureDetector(
      onLongPress: () => _showCommentActions(context, comment, post, isMentor),
      child: Dismissible(
        key: Key(comment.id),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          setState(() {
            _replyToAuthor = comment.author;
          });
          return false;
        },
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16.0),
          child: const Icon(Icons.reply_rounded, color: AppTokens.textTertiary),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppTokens.spacingMd),
          child: Row(
            mainAxisAlignment: isMentor ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMentor) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(comment.avatarUrl),
                ),
                const SizedBox(width: AppTokens.spacingSm),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(AppTokens.spacingMd),
                  decoration: BoxDecoration(
                    color: isMentor
                        ? AppTokens.primaryOlive
                        : (isDark ? Theme.of(context).cardTheme.color : AppTokens.backgroundLight),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppTokens.radiusCard),
                      topRight: const Radius.circular(AppTokens.radiusCard),
                      bottomLeft: isMentor ? const Radius.circular(AppTokens.radiusCard) : Radius.zero,
                      bottomRight: isMentor ? Radius.zero : const Radius.circular(AppTokens.radiusCard),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTokens.primaryOliveDark.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reply indicator
                      if (comment.replyToAuthor != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: isMentor
                                ? AppTokens.backgroundLight.withValues(alpha: 0.1)
                                : AppTokens.primaryOlive.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                            border: Border(
                              left: BorderSide(
                                color: isMentor ? AppTokens.backgroundLight : AppTokens.primaryOlive,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            'Reply to ${comment.replyToAuthor}',
                            style: TextStyle(
                              fontSize: 11,
                              color: isMentor ? AppTokens.backgroundLight.withValues(alpha: 0.7) : AppTokens.primaryOlive,
                            ),
                          ),
                        ),
                      ],

                      // Author name
                      if (!isMentor)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            comment.author,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTokens.primaryOlive,
                            ),
                          ),
                        ),
                      // Comment text
                      Text(
                        comment.text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isMentor ? AppTokens.backgroundLight : null,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Time + reactions row
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            comment.time,
                            style: TextStyle(
                              fontSize: 10,
                              color: isMentor ? AppTokens.backgroundLight.withValues(alpha: 0.6) : AppTokens.textTertiary,
                            ),
                          ),
                          if (comment.reactions.hearts > 0) ...[
                            const SizedBox(width: 8),
                            Icon(Icons.favorite, size: 12, color: isMentor ? AppTokens.backgroundLight.withValues(alpha: 0.8) : const Color(0xFFFF4D6A)),
                            const SizedBox(width: 2),
                            Text(
                              '${comment.reactions.hearts}',
                              style: TextStyle(
                                fontSize: 10,
                                color: isMentor ? AppTokens.backgroundLight.withValues(alpha: 0.6) : AppTokens.textTertiary,
                              ),
                            ),
                          ],
                          if (comment.reactions.fire > 0) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.local_fire_department, size: 12, color: isMentor ? AppTokens.backgroundLight.withValues(alpha: 0.8) : const Color(0xFFFF9500)),
                            const SizedBox(width: 2),
                            Text(
                              '${comment.reactions.fire}',
                              style: TextStyle(
                                fontSize: 10,
                                color: isMentor ? AppTokens.backgroundLight.withValues(alpha: 0.6) : AppTokens.textTertiary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isMentor) ...[
                const SizedBox(width: AppTokens.spacingSm),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(comment.avatarUrl),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showCommentActions(BuildContext context, CommentModel comment, PostModel post, bool isMentor) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Reactions row
            Padding(
              padding: const EdgeInsets.all(AppTokens.spacingLg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildReactionButton(ctx, '❤️'),
                  const SizedBox(width: AppTokens.spacingLg),
                  _buildReactionButton(ctx, '👍'),
                  const SizedBox(width: AppTokens.spacingLg),
                  _buildReactionButton(ctx, '🔥'),
                  const SizedBox(width: AppTokens.spacingLg),
                  _buildReactionButton(ctx, '😂'),
                  const SizedBox(width: AppTokens.spacingLg),
                  _buildReactionButton(ctx, '😮'),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.reply_rounded),
              title: const Text('Reply'),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => _replyToAuthor = comment.author);
              },
            ),
            // Mentor can delete any comment
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppTokens.statusRed),
              title: const Text('Delete Comment', style: TextStyle(color: AppTokens.statusRed)),
              onTap: () {
                Navigator.pop(ctx);
                context.read<PostsProvider>().deleteComment(post.id, comment.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionButton(BuildContext context, String emoji) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppTokens.surfaceElevated,
          borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
        ),
        child: Center(
          child: Text(emoji, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, PostModel post, bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppTokens.spacingLg,
        AppTokens.spacingMd,
        AppTokens.spacingMd,
        MediaQuery.of(context).viewInsets.bottom + AppTokens.spacingMd,
      ),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).scaffoldBackgroundColor : AppTokens.backgroundLight,
        border: Border(
          top: BorderSide(color: AppTokens.borderSubtle, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reply indicator
          if (_replyToAuthor != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingMd, vertical: AppTokens.spacingSm),
              margin: const EdgeInsets.only(bottom: AppTokens.spacingSm),
              decoration: BoxDecoration(
                color: AppTokens.primaryOlive.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(Icons.reply_rounded, size: 16, color: AppTokens.primaryOlive),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Replying to $_replyToAuthor',
                      style: const TextStyle(fontSize: 12, color: AppTokens.primaryOlive, fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _replyToAuthor = null),
                    child: const Icon(Icons.close, size: 16, color: AppTokens.textTertiary),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingMd),
                  decoration: BoxDecoration(
                    color: isDark ? AppTokens.overlayLight : AppTokens.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
                  ),
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    maxLines: null,
                  ),
                ),
              ),
              const SizedBox(width: AppTokens.spacingSm),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTokens.primaryOlive,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppTokens.backgroundLight, size: 20),
                  onPressed: () => _sendComment(context, post),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendComment(BuildContext context, PostModel post) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final newComment = CommentModel(
      id: 'new_${DateTime.now().millisecondsSinceEpoch}',
      postId: post.id,
      author: MockData.mentorName,
      avatarUrl: MockData.profileImageUrl,
      isMentor: true,
      text: text,
      time: 'now',
      replyToAuthor: _replyToAuthor,
    );

    context.read<PostsProvider>().addComment(post.id, newComment);
    _messageController.clear();
    setState(() => _replyToAuthor = null);
  }
}
