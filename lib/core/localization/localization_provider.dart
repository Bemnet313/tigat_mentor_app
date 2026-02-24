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
      'general': 'General'
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
      'general': 'አጠቃላይ'
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
