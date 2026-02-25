import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../../../core/mock_data/mock_data.dart';

class PostsProvider extends ChangeNotifier {
  final List<PostModel> _posts = [];

  List<PostModel> get posts => List.unmodifiable(_posts);

  PostsProvider() {
    _posts.addAll(MockData.dummyPosts);
  }

  void addPost(PostModel post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  void deletePost(String postId) {
    _posts.removeWhere((p) => p.id == postId);
    notifyListeners();
  }

  void toggleHidePost(String postId) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].isHidden = !_posts[index].isHidden;
      notifyListeners();
    }
  }

  void addComment(String postId, CommentModel comment) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].comments.add(comment);
      notifyListeners();
    }
  }

  void deleteComment(String postId, String commentId) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].comments.removeWhere((c) => c.id == commentId);
      notifyListeners();
    }
  }

  void togglePostReaction(String postId, String reactionType) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _posts[index];
      switch (reactionType) {
        case 'heart': post.reactions.hearts++; break;
        case 'thumbsUp': post.reactions.thumbsUp++; break;
        case 'fire': post.reactions.fire++; break;
      }
      notifyListeners();
    }
  }
}
