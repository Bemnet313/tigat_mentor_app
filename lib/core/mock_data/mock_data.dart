
import '../../../features/posts/models/post_model.dart' show PostModel, PostType, PostReactions, CommentModel;

class MockData {
  // Screen 1: Dashboard KPIs
  static const double currentMonthEarningsETB = 14500.00;
  static const int activeStudents = 124;
  static const int newFollowersMonthly = 38;
  static const double pendingWithdrawalsETB = 2500.00;
  
  static const List<double> monthlyRevenueGraphData = [
    1200, 1500, 800, 2200, 3100, 2800, 14500
  ];
  
  // Mentor Profile
  static const String mentorName = "Senai";
  static const String mentorUsername = "@senai";
  static const String mentorPhone = "+251 911 123 456";
  static const String mentorEmail = "senai@tigat.net";
  static const String mentorBio = "Passionate educator and Flutter developer helping students across Ethiopia build real-world mobile apps. 🇪🇹";
  static const String profileImageUrl = "https://i.pravatar.cc/150?img=11";
  static const String bannerImageUrl = "https://picsum.photos/1280/720?random=1";
  static const String bankAccount = "CBE - 1000123456789";

  // Students (Screen 5)
  static final List<Map<String, dynamic>> students = [
    {"name": "Selamawit T.", "course": "Dart Masterclass", "status": "Active", "avatar": "https://i.pravatar.cc/150?img=5"},
    {"name": "Ermias M.", "course": "Premium Community", "status": "Active", "avatar": "https://i.pravatar.cc/150?img=12"},
    {"name": "Helen K.", "course": "Dart Masterclass", "status": "Expired", "avatar": "https://i.pravatar.cc/150?img=9"},
  ];
  
  // Courses (Screen 6)
  static final List<Map<String, dynamic>> courses = [
    {"title": "Dart Masterclass 2024", "status": "Published", "price": "1500 ETB", "students": 85},
    {"title": "Flutter UI Animations", "status": "Draft", "price": "800 ETB", "students": 0},
  ];

  // Withdrawals (Screen 4)
  static final List<Map<String, dynamic>> withdrawals = [
    {"amount": "2500.00 ETB", "status": "Pending", "date": "Oct 12, 2024"},
    {"amount": "5000.00 ETB", "status": "Completed", "date": "Sep 28, 2024"},
    {"amount": "1200.00 ETB", "status": "Rejected", "date": "Sep 15, 2024"},
  ];

  // Community Rooms
  static final List<Map<String, dynamic>> chatMessages = [
    {"id": "c1", "author": "Selamawit T.", "isMentor": false, "text": "ሰላም መምህር፣ የዛሬው ትምህርት በጣም ጠቃሚ ነበር!", "time": "10:00 AM", "avatar": "https://i.pravatar.cc/150?img=5"},
    {"id": "c2", "author": "Senai", "isMentor": true, "text": "አመሰግናለሁ ሰላማዊት! ጥያቄ ካለሽ መጠየቅ ትችያለሽ።", "time": "10:05 AM", "avatar": profileImageUrl},
    {"id": "c3", "author": "Ermias M.", "isMentor": false, "text": "መምህር፣ Firebase Auth ሲሰራ error እያመጣብኝ ነው።", "time": "10:12 AM", "avatar": "https://i.pravatar.cc/150?img=12"},
    {"id": "c4", "author": "Helen K.", "isMentor": false, "text": "I had a similar issue. Check your SHA-1 key.", "time": "10:15 AM", "avatar": "https://i.pravatar.cc/150?img=9"},
    {"id": "c5", "author": "Ermias M.", "isMentor": false, "text": "Thanks Helen, let me check that.", "time": "10:16 AM", "avatar": "https://i.pravatar.cc/150?img=12"},
    {"id": "c6", "author": "Ermias M.", "isMentor": false, "text": "It worked! Thank you 🙏", "time": "10:30 AM", "avatar": "https://i.pravatar.cc/150?img=12"},
    {"id": "c7", "author": "Senai", "isMentor": true, "text": "Great teamwork guys! This is what the community is for.", "time": "10:35 AM", "avatar": profileImageUrl},
    {"id": "c8", "author": "Selamawit T.", "isMentor": false, "text": "በቀጣይ ስለ ምን እናያለን?", "time": "11:00 AM", "avatar": "https://i.pravatar.cc/150?img=5"},
    {"id": "c9", "author": "Senai", "isMentor": true, "text": "We will cover advanced animations next week!", "time": "11:15 AM", "avatar": profileImageUrl},
    {"id": "c10", "author": "Helen K.", "isMentor": false, "text": "Awesome, can't wait!", "time": "11:20 AM", "avatar": "https://i.pravatar.cc/150?img=9"},
    {"id": "c11", "author": "Ermias M.", "isMentor": false, "text": "Will it include Rive animations?", "time": "11:25 AM", "avatar": "https://i.pravatar.cc/150?img=12"},
    {"id": "c12", "author": "Senai", "isMentor": true, "text": "Yes, we will touch on Rive integration as well.", "time": "11:30 AM", "avatar": profileImageUrl},
    {"id": "c13", "author": "Dawit Z.", "isMentor": false, "text": "መምህር፣ ትምህርቱን ዛሬ ማታ ማየት እችላለሁ?", "time": "12:00 PM", "avatar": "https://i.pravatar.cc/150?img=33"},
    {"id": "c14", "author": "Senai", "isMentor": true, "text": "አዎ ዳዊት፣ ቪዲዮው ሁሌም accessible ነው።", "time": "12:05 PM", "avatar": profileImageUrl},
    {"id": "c15", "author": "Dawit Z.", "isMentor": false, "text": "እናመሰግናለን!", "time": "12:10 PM", "avatar": "https://i.pravatar.cc/150?img=33"},
  ];

  static final List<Map<String, dynamic>> publishedVideos = [
    {"id": "v1", "title": "Dart Fundamentals Pt 1", "thumbnail": "https://picsum.photos/400/225?random=10", "duration": "45:20"},
    {"id": "v2", "title": "Building Responsive UIs", "thumbnail": "https://picsum.photos/400/225?random=11", "duration": "32:15"},
    {"id": "v3", "title": "State Management with Provider", "thumbnail": "https://picsum.photos/400/225?random=12", "duration": "50:05"},
    {"id": "v4", "title": "Firebase Integration", "thumbnail": "https://picsum.photos/400/225?random=13", "duration": "1:05:30"},
  ];

  // ──────────────────────────────────────────────────────────────
  // DUMMY POSTS — 20+ multilingual posts for the Posts Feed
  // ──────────────────────────────────────────────────────────────
  static List<PostModel> get dummyPosts {
    final now = DateTime.now();
    return [
      PostModel(
        id: 'p1',
        type: PostType.text,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: '🎉 Welcome to the Tigat mentor feed! This is where I share insights, tips, and updates directly with you. Make sure to check back daily.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        reactions: PostReactions(hearts: 47, thumbsUp: 31, fire: 19),
        comments: _commentsForPost('p1'),
      ),
      PostModel(
        id: 'p2',
        type: PostType.image,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'ዛሬ ለዳርት ቋንቋ ልጀምር። ወደፊት የምናያቸው ርዕሶች ሁሉ ለሥራ የሚረዱ ናቸው። 🇪🇹',
        mediaUrl: 'https://picsum.photos/800/450?random=20',
        timestamp: now.subtract(const Duration(hours: 1)),
        reactions: PostReactions(hearts: 82, thumbsUp: 64, fire: 38),
        comments: _commentsForPost('p2'),
      ),
      PostModel(
        id: 'p3',
        type: PostType.video,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'New lesson dropped! 🎬 "Dart Fundamentals Pt 1" — cover everything from variables to functions. Watch it at your own pace.',
        mediaUrl: 'https://picsum.photos/800/450?random=21',
        timestamp: now.subtract(const Duration(hours: 3)),
        reactions: PostReactions(hearts: 120, thumbsUp: 95, fire: 67),
        comments: _commentsForPost('p3'),
      ),
      PostModel(
        id: 'p4',
        type: PostType.poll,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Quick poll! Which topic should I cover next?',
        pollQuestion: 'What do you want to learn next?',
        pollOptions: ['Advanced Animations', 'Firebase Advanced', 'Clean Architecture', 'Testing in Flutter'],
        timestamp: now.subtract(const Duration(hours: 5)),
        reactions: PostReactions(hearts: 34, thumbsUp: 56, fire: 22),
        comments: _commentsForPost('p4'),
      ),
      PostModel(
        id: 'p5',
        type: PostType.text,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'ጠርተው ወደ community chat ቪዲዮ ዝግጅት ታክለዋል። ሁሉም ተሳታፊዎች ጥሩ ሰዓት ያለ ቅሬታ ሊጠቀሙ ይችላሉ!',
        timestamp: now.subtract(const Duration(hours: 8)),
        reactions: PostReactions(hearts: 29, thumbsUp: 18, fire: 12),
        comments: _commentsForPost('p5'),
      ),
      PostModel(
        id: 'p6',
        type: PostType.blog,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Blog: Why I switched from React Native to Flutter for building the Tigat app — performance, design flexibility, and community support all played a role. Read the full story below 👇',
        timestamp: now.subtract(const Duration(hours: 12)),
        reactions: PostReactions(hearts: 74, thumbsUp: 60, fire: 41),
        comments: _commentsForPost('p6'),
      ),
      PostModel(
        id: 'p7',
        type: PostType.voice,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: '🎙️ Voice note: Quick tip on using `const` constructors in Flutter to drastically improve rebuild performance.',
        timestamp: now.subtract(const Duration(hours: 15)),
        reactions: PostReactions(hearts: 55, thumbsUp: 43, fire: 28),
        comments: _commentsForPost('p7'),
      ),
      PostModel(
        id: 'p8',
        type: PostType.image,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'ዛሬ ተማሪዎቼ Flutter UI ፕሮጀክቶቻቸውን አቀረቡ። ትልቅ ኩሩ ነኝ! 🏆',
        mediaUrl: 'https://picsum.photos/800/450?random=22',
        timestamp: now.subtract(const Duration(hours: 20)),
        reactions: PostReactions(hearts: 98, thumbsUp: 77, fire: 55),
        comments: _commentsForPost('p8'),
      ),
      PostModel(
        id: 'p9',
        type: PostType.text,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Reminder: Monthly live Q&A session is this Friday at 7PM Addis Ababa time. Drop your questions in the comments! 📅',
        timestamp: now.subtract(const Duration(days: 1)),
        reactions: PostReactions(hearts: 62, thumbsUp: 50, fire: 33),
        comments: _commentsForPost('p9'),
      ),
      PostModel(
        id: 'p10',
        type: PostType.video,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Tutorial: Building the full Tigat UI from scratch. This video covers the nav bar, scaffold, and theming.',
        mediaUrl: 'https://picsum.photos/800/450?random=23',
        timestamp: now.subtract(const Duration(days: 1, hours: 5)),
        reactions: PostReactions(hearts: 113, thumbsUp: 88, fire: 72),
        comments: _commentsForPost('p10'),
      ),
      PostModel(
        id: 'p11',
        type: PostType.text,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Pro tip of the day: Use `ListView.separated` instead of `ListView.builder` when you need consistent dividers — it is cleaner and more readable.',
        timestamp: now.subtract(const Duration(days: 2)),
        reactions: PostReactions(hearts: 45, thumbsUp: 39, fire: 21),
        comments: _commentsForPost('p11'),
      ),
      PostModel(
        id: 'p12',
        type: PostType.poll,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'ቀጣዩ ኮርስ ምን ርዕስ ይሁን? ድምፃችሁን ስጡ! 🗳️',
        pollQuestion: 'ቀጣዩ ኮርስ ምን ይሁን?',
        pollOptions: ['Backend with Dart', 'UI/UX Design', 'AI Integration', 'Business & Marketing'],
        timestamp: now.subtract(const Duration(days: 2, hours: 8)),
        reactions: PostReactions(hearts: 38, thumbsUp: 29, fire: 17),
        comments: _commentsForPost('p12'),
      ),
      PostModel(
        id: 'p13',
        type: PostType.image,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Weekend challenge: Recreate this beautiful card UI in Flutter. Share your code in the Community room! 💪',
        mediaUrl: 'https://picsum.photos/800/450?random=24',
        timestamp: now.subtract(const Duration(days: 3)),
        reactions: PostReactions(hearts: 107, thumbsUp: 83, fire: 66),
        comments: _commentsForPost('p13'),
      ),
      PostModel(
        id: 'p14',
        type: PostType.text,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'State management comparison 2025: Provider vs. Riverpod vs. Bloc. After extensive use, here is my honest take on which one to use for which project size.',
        timestamp: now.subtract(const Duration(days: 3, hours: 3)),
        reactions: PostReactions(hearts: 89, thumbsUp: 71, fire: 48),
        comments: _commentsForPost('p14'),
      ),
      PostModel(
        id: 'p15',
        type: PostType.voice,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: '🎙️ ድምፅ ልኬ ቴምፕሌቶቻችሁ ለምን አስፈላጊ እንደሆነ አብራርቻለሁ። ዓማርኛ ቋንቋ ለሚናገሩ ሁሉ።',
        timestamp: now.subtract(const Duration(days: 4)),
        reactions: PostReactions(hearts: 41, thumbsUp: 33, fire: 19),
        comments: _commentsForPost('p15'),
      ),
      PostModel(
        id: 'p16',
        type: PostType.video,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'New: Firebase Auth integration with Google Sign-In — full walk-through from SHA setup to production config.',
        mediaUrl: 'https://picsum.photos/800/450?random=25',
        timestamp: now.subtract(const Duration(days: 4, hours: 6)),
        reactions: PostReactions(hearts: 133, thumbsUp: 102, fire: 78),
        comments: _commentsForPost('p16'),
      ),
      PostModel(
        id: 'p17',
        type: PostType.blog,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Blog: The 5 Flutter mistakes that juniors make (and how to avoid them). Number 3 might surprise you.',
        timestamp: now.subtract(const Duration(days: 5)),
        reactions: PostReactions(hearts: 95, thumbsUp: 78, fire: 54),
        comments: _commentsForPost('p17'),
      ),
      PostModel(
        id: 'p18',
        type: PostType.text,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Huge milestone! 🚀 The Tigat platform now has 1,000+ enrolled students. Thank you for your trust and support. This is just the beginning!',
        timestamp: now.subtract(const Duration(days: 6)),
        reactions: PostReactions(hearts: 201, thumbsUp: 157, fire: 120),
        comments: _commentsForPost('p18'),
      ),
      PostModel(
        id: 'p19',
        type: PostType.image,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'ሞቅ ያለ እንኳን ደህና መጣ ለአዲሶቹ ተማሪዎቻችን! ምርጥ ቤተሰብ ነን። 🌿',
        mediaUrl: 'https://picsum.photos/800/450?random=26',
        timestamp: now.subtract(const Duration(days: 7)),
        reactions: PostReactions(hearts: 77, thumbsUp: 59, fire: 36),
        comments: _commentsForPost('p19'),
      ),
      PostModel(
        id: 'p20',
        type: PostType.text,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'A gentle reminder: consistency beats intensity every time. 30 minutes of Flutter practice daily will take you further than a 6-hour weekend binge. 🌱',
        timestamp: now.subtract(const Duration(days: 8)),
        reactions: PostReactions(hearts: 156, thumbsUp: 119, fire: 87),
        comments: _commentsForPost('p20'),
      ),
      PostModel(
        id: 'p21',
        type: PostType.image,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'Flutter vs SwiftUI vs Jetpack Compose — a visual comparison of how the same UI looks on all three. Spoiler: Flutter wins on consistency.',
        mediaUrl: 'https://picsum.photos/800/450?random=27',
        timestamp: now.subtract(const Duration(days: 10)),
        reactions: PostReactions(hearts: 88, thumbsUp: 70, fire: 45),
        comments: _commentsForPost('p21'),
      ),
      PostModel(
        id: 'p22',
        type: PostType.poll,
        authorName: mentorName,
        authorAvatarUrl: profileImageUrl,
        isMentor: true,
        text: 'ልምምዱ ለዚህ ሳምንት ምን ያህል ሰዓት ስሰጡ ነበር? 📊',
        pollQuestion: 'Weekly study hours?',
        pollOptions: ['< 2 hours', '2–5 hours', '5–10 hours', '10+ hours'],
        timestamp: now.subtract(const Duration(days: 12)),
        reactions: PostReactions(hearts: 31, thumbsUp: 25, fire: 14),
        comments: _commentsForPost('p22'),
      ),
    ];
  }

  static List<CommentModel> _commentsForPost(String postId) {
    final List<Map<String, dynamic>> pool = [
      {'author': 'Selamawit T.', 'avatar': 'https://i.pravatar.cc/150?img=5',  'mentor': false, 'text': 'ከልብ አመሰግናለሁ! ይህ ትምህርት ብዙ ነገር አሳይቶኛል። 🙏'},
      {'author': 'Ermias M.',    'avatar': 'https://i.pravatar.cc/150?img=12', 'mentor': false, 'text': 'This is exactly what I needed. Thank you, Senai!'},
      {'author': 'Helen K.',     'avatar': 'https://i.pravatar.cc/150?img=9',  'mentor': false, 'text': 'Amazing content as always. Keep it up! 🔥'},
      {'author': 'Dawit Z.',     'avatar': 'https://i.pravatar.cc/150?img=33', 'mentor': false, 'text': 'ያ ፖሊ በጣም አስቂኝ ሆኖ ሁሌም ጠቃሚ ነው!'},
      {'author': 'Meron A.',     'avatar': 'https://i.pravatar.cc/150?img=47', 'mentor': false, 'text': 'I shared this with my study group. Super useful.'},
      {'author': 'Senai',        'avatar': profileImageUrl,                    'mentor': true,  'text': 'Thank you all for the support! Keep learning 💪'},
      {'author': 'Kidus B.',     'avatar': 'https://i.pravatar.cc/150?img=52', 'mentor': false, 'text': 'ትምህርቱ ሲያበቃ ምን እናያለን?'},
      {'author': 'Tigist F.',    'avatar': 'https://i.pravatar.cc/150?img=44', 'mentor': false, 'text': 'Can we get a PDF cheatsheet for this topic?'},
      {'author': 'Senai',        'avatar': profileImageUrl,                    'mentor': true,  'text': 'Great idea Tigist! I will create one this weekend.'},
      {'author': 'Abel C.',      'avatar': 'https://i.pravatar.cc/150?img=60', 'mentor': false, 'text': 'This is why Tigat is the best learning platform. ❤️'},
    ];

    // pick a repeatable but varied subset per postId
    final hash = postId.hashCode.abs() % 5;
    final count = 5 + hash;
    return pool.take(count).toList().asMap().entries.map((entry) {
      final i = entry.key;
      final m = entry.value;
      return CommentModel(
        id: '${postId}_c$i',
        postId: postId,
        author: m['author'],
        avatarUrl: m['avatar'],
        isMentor: m['mentor'],
        text: m['text'],
        time: '${(i + 1) * 3}m ago',
        reactions: PostReactions(
          hearts: (i * 7 + 3),
          thumbsUp: (i * 4 + 1),
          fire: (i * 2),
        ),
      );
    }).toList();
  }
}
