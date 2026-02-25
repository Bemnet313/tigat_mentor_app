import 'package:flutter/material.dart';

enum PostType { text, image, poll, voice, video, blog }

class PostReactions {
  int hearts;
  int thumbsUp;
  int fire;

  PostReactions({this.hearts = 0, this.thumbsUp = 0, this.fire = 0});
}

class CommentModel {
  final String id;
  final String postId;
  final String author;
  final String avatarUrl;
  final bool isMentor;
  final String text;
  final String time;
  final String? replyToAuthor;
  PostReactions reactions;

  CommentModel({
    required this.id,
    required this.postId,
    required this.author,
    required this.avatarUrl,
    required this.isMentor,
    required this.text,
    required this.time,
    this.replyToAuthor,
    PostReactions? reactions,
  }) : reactions = reactions ?? PostReactions();
}

class PostModel {
  final String id;
  final PostType type;
  final String authorName;
  final String authorAvatarUrl;
  final bool isMentor;
  final String text;
  final String? mediaUrl;
  final String? pollQuestion;
  final List<String>? pollOptions;
  final DateTime timestamp;
  PostReactions reactions;
  final List<CommentModel> comments;
  bool isHidden;

  PostModel({
    required this.id,
    required this.type,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.isMentor,
    required this.text,
    this.mediaUrl,
    this.pollQuestion,
    this.pollOptions,
    required this.timestamp,
    PostReactions? reactions,
    List<CommentModel>? comments,
    this.isHidden = false,
  })  : reactions = reactions ?? PostReactions(),
        comments = comments ?? [];

  String get formattedTime {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  // For displaying the right icon
  IconData get typeIcon {
    switch (type) {
      case PostType.image: return Icons.image_rounded;
      case PostType.poll: return Icons.poll_rounded;
      case PostType.voice: return Icons.mic_rounded;
      case PostType.video: return Icons.play_circle_rounded;
      case PostType.blog: return Icons.article_rounded;
      case PostType.text: return Icons.text_fields_rounded;
    }
  }
}
