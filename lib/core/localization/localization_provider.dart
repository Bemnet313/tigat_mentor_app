import 'package:flutter/material.dart';

class LocalizedStrings {
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'dashboard': 'Dashboard',
      'earnings': 'Total Earnings',
      'active_students': 'Active Students',
      'new_followers': 'New Followers',
      'pending_withdrawals': 'Pending Withdrawals',
      'new_post': 'New Post',
      'withdraw': 'Withdraw',
      'community': 'Community',
      'my_courses': 'My Courses',
      'no_earnings': 'No earnings yet. Start engaging your students!',
      'this_month': 'This Month',
      'ask_mentor': 'Ask Mentor',
      'announcements': 'Announcements',
      'general': 'General',
      'profile': 'Profile',
      'personal_information': 'Personal Information',
      'name': 'Name',
      'username': 'Username',
      'phone': 'Phone',
      'email': 'Email',
      'bio': 'Bio',
      'write_something': 'Write something about yourself...',
      'banner_image': 'Banner Image',
      'security': 'Security',
      'change_password': 'Change Password',
      'app_settings': 'App Settings',
      'dark_mode': 'Dark Mode',
      'language_amharic': 'Language (Amharic)',
      'save_changes': 'Save Changes',
      'post_something_today': 'Post something Today !',
      'revenue_overview': 'Revenue Overview',
      'students': 'Students',
      'dashboard_nav': 'Dashboard',
    },
    'am': {
      'dashboard': 'ዳሽቦርድ',
      'earnings': 'አጠቃላይ ገቢ',
      'active_students': 'ንቁ ተማሪዎች',
      'new_followers': 'አዲስ ተከታዮች',
      'pending_withdrawals': 'በመጠባበቅ ላይ ያሉ ወጪዎች',
      'new_post': 'አዲስ ልጥፍ',
      'withdraw': 'ወጪ ማድረግ',
      'community': 'ማህበረሰብ',
      'my_courses': 'ትምህርቶቼ',
      'no_earnings': 'እስካሁን ምንም ገቢ የለም። ከተማሪዎችዎ ጋር መሳተፍ ይጀምሩ!',
      'this_month': 'በዚህ ወር',
      'ask_mentor': 'አስተማሪን ጠይቅ',
      'announcements': 'ማስታወቂያዎች',
      'general': 'አጠቃላይ',
      'profile': 'መገለጫ',
      'personal_information': 'የግል መረጃ',
      'name': 'ስም',
      'username': 'የተጠቃሚ ስም',
      'phone': 'ስልክ',
      'email': 'ኢሜል',
      'bio': 'የግል ማስታወሻ',
      'write_something': 'ስለ እራስዎ አንድ ነገር ይፃፉ...',
      'banner_image': 'የጀርባ ምስል',
      'security': 'ደህንነት',
      'change_password': 'የይለፍ ቃል ይቀይሩ',
      'app_settings': 'የመተግበሪያ ቅንብሮች',
      'dark_mode': 'ጨለማ ገጽታ',
      'language_amharic': 'ቋንቋ (አማርኛ)',
      'save_changes': 'ለውጦችን ያስቀምጡ',
      'post_something_today': 'ዛሬ አንድ ነገር ይለጥፉ !',
      'revenue_overview': 'የገቢ ማጠቃለያ',
      'students': 'ተማሪዎች',
      'dashboard_nav': 'ዳሽቦርድ',
    },
  };

  static String getString(String localeCode, String key) {
    return _localizedValues[localeCode]?[key] ?? _localizedValues['en']?[key] ?? key;
  }
}

class LocalizationProvider extends ChangeNotifier {
  String _currentLocale = 'en';

  String get currentLocale => _currentLocale;

  bool get isAmharic => _currentLocale == 'am';

  void toggleLanguage() {
    _currentLocale = _currentLocale == 'en' ? 'am' : 'en';
    notifyListeners();
  }

  String translate(String key) {
    return LocalizedStrings.getString(_currentLocale, key);
  }
}
