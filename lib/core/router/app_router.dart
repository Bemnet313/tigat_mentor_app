import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/community/screens/community_screen.dart';
import '../../features/students/screens/students_screen.dart';
import '../../features/wallet/screens/wallet_screen.dart';
import '../../features/courses/screens/courses_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../mock_data/mock_data.dart';
import '../theme/theme.dart';
import '../constants/app_strings.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const _MainScaffold(child: DashboardScreen()),
      ),
      GoRoute(
        path: '/community',
        builder: (context, state) => const _MainScaffold(child: CommunityScreen()),
      ),
      GoRoute(
        path: '/students',
        builder: (context, state) => const _MainScaffold(child: StudentsScreen()),
      ),
      GoRoute(
        path: '/wallet',
        builder: (context, state) => const _MainScaffold(child: WalletScreen()),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const _MainScaffold(child: CoursesScreen()),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}

class _MainScaffold extends StatelessWidget {
  final Widget child;

  const _MainScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = _calculateSelectedIndex(location);
    String pageTitle = _getPageTitle(location);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 130,
        leading: Center(
          child: GestureDetector(
            onTap: () => context.go('/'),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: location == '/'
                    ? AppTheme.primaryStatusGreen
                    : AppTheme.primaryStatusGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: location == '/'
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryStatusGreen.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.dashboard_rounded,
                    size: 14,
                    color: location == '/' ? Colors.white : AppTheme.primaryStatusGreen,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    AppStrings.navDashboard,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: location == '/' ? Colors.white : AppTheme.primaryStatusGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        title: _buildLogo(),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () => context.push('/profile'),
              child: Center(
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primaryStatusGreen.withValues(alpha: 0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryStatusGreen.withValues(alpha: 0.1),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(MockData.profileImageUrl),
                    backgroundColor: AppTheme.backgroundLight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          border: Border(
            top: const BorderSide(color: AppTheme.borderLight, width: 1.0),
          ),
        ),
        child: NavigationBar(
          backgroundColor: AppTheme.surfaceWhite,
          surfaceTintColor: Colors.transparent,
          selectedIndex: currentIndex == -1 ? 0 : currentIndex,
          indicatorColor: Colors.transparent, // Removing default pill
          onDestinationSelected: (index) => _onItemTapped(index, context),
          destinations: [
            _buildNavDestination(currentIndex, 0, Icons.people_outline, Icons.people, AppStrings.navCommunity),
            _buildNavDestination(currentIndex, 1, Icons.school_outlined, Icons.school, AppStrings.navStudents),
            _buildNavDestination(currentIndex, 2, Icons.monetization_on_outlined, Icons.monetization_on, AppStrings.navWithdraw),
            _buildNavDestination(currentIndex, 3, Icons.play_lesson_outlined, Icons.play_lesson, AppStrings.navMyCourses),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: const [AppTheme.midnightEmerald, AppTheme.darkMidnightEmerald],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.midnightEmerald.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/tigat_logo.png',
        height: 22,
        fit: BoxFit.contain,
      ),
    );
  }

  NavigationDestination _buildNavDestination(int currentIndex, int index, IconData icon, IconData selectedIcon, String label) {
    bool isSelected = currentIndex == index;
    return NavigationDestination(
      icon: Icon(icon, color: AppTheme.textSecondary),
      selectedIcon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.electricEmerald.withValues(alpha: 0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(selectedIcon, color: AppTheme.electricEmerald), // Electric Emerald
      ),
      label: label,
    );
  }

  String _getPageTitle(String location) {
    if (location.startsWith('/community')) return AppStrings.navCommunity;
    if (location.startsWith('/students')) return AppStrings.navStudents;
    if (location.startsWith('/wallet')) return AppStrings.navWithdraw;
    if (location.startsWith('/courses')) return AppStrings.navMyCourses;
    return AppStrings.navDashboard;
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/students')) return 1;
    if (location.startsWith('/wallet')) return 2;
    if (location.startsWith('/courses')) return 3;
    if (location.startsWith('/community')) return 0;
    return -1; // dashboard
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/community');
        break;
      case 1:
        context.go('/students');
        break;
      case 2:
        context.go('/wallet');
        break;
      case 3:
        context.go('/courses');
        break;
    }
  }
}
