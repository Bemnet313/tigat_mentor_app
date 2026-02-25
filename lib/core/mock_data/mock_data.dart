
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
}
