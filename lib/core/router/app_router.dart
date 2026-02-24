import 'package:go_router/go_router.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/community/screens/community_screen.dart';
import '../../features/students/screens/students_screen.dart';
import '../../features/wallet/screens/wallet_screen.dart';
import '../../features/courses/screens/courses_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../widgets/app_scaffold.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AppScaffold(child: DashboardScreen()),
      ),
      GoRoute(
        path: '/community',
        builder: (context, state) => const AppScaffold(child: CommunityScreen()),
      ),
      GoRoute(
        path: '/students',
        builder: (context, state) => const AppScaffold(child: StudentsScreen()),
      ),
      GoRoute(
        path: '/wallet',
        builder: (context, state) => const AppScaffold(child: WalletScreen()),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const AppScaffold(child: CoursesScreen()),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
