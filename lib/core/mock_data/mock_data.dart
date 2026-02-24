
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
  static const String mentorName = "Abebe Kebede";
  static const String mentorUsername = "@abebe_kebede";
  static const String mentorPhone = "+251 911 123 456";
  static const String mentorEmail = "abebe@tigat.net";
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
}
