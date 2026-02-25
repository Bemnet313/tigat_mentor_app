import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../design/tokens.dart';
import '../mock_data/mock_data.dart';
import '../localization/localization_provider.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final bool isDashboard = location == '/';

    return Scaffold(
      appBar: _buildAppBar(context, location, isDashboard),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          gradient: RadialGradient(
            center: const Alignment(0.5, -0.2), // slightly top-right
            radius: 1.5,
            colors: [
              Theme.of(context).brightness == Brightness.dark 
                  ? AppTokens.primaryOliveDark.withValues(alpha: 0.3) 
                  : AppTokens.accentSoft.withValues(alpha: 0.15),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: child,
      ),
      bottomNavigationBar: _buildBottomNav(context, location),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String location, bool isDashboard) {
    final loc = context.watch<LocalizationProvider>();

    return AppBar(
      leadingWidth: 130,
      leading: Center(
        child: GestureDetector(
          onTap: () => context.go('/'),
          child: AnimatedContainer(
            duration: AppTokens.durationShort,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              color: isDashboard
                  ? AppTokens.primaryOlive
                  : AppTokens.primaryOlive.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTokens.radiusPill),
              boxShadow: isDashboard ? AppTokens.elevatedShadow : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.dashboard_rounded,
                  size: 14,
                  color: isDashboard ? AppTokens.backgroundLight : AppTokens.primaryOlive,
                ),
                const SizedBox(width: 4),
                Text(
                  loc.translate('dashboard_nav'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDashboard ? AppTokens.backgroundLight : AppTokens.primaryOlive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: _buildLogo(context),
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
                    color: AppTokens.primaryOlive.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 17,
                  backgroundImage: NetworkImage(MockData.profileImageUrl),
                  backgroundColor: AppTokens.backgroundLight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDark 
            ? AppTokens.primaryOliveDark 
            : AppTokens.backgroundLight,
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
        border: Border.all(
          color: AppTokens.primaryOlive.withValues(alpha: isDark ? 0.4 : 0.1),
        ),
      ),
      child: Image.asset(
        'assets/images/tigat_logo.png',
        height: 20,
        fit: BoxFit.contain,
        color: isDark ? AppTokens.backgroundLight : AppTokens.primaryOlive,
        errorBuilder: (context, error, stackTrace) => Text(
          'TIGU',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: isDark ? AppTokens.backgroundLight : AppTokens.primaryOlive,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, String location) {
    final loc = context.watch<LocalizationProvider>();
    int getIndex() {
      if (location.startsWith('/community')) return 0;
      if (location.startsWith('/posts')) return 1;
      if (location.startsWith('/courses')) return 2;
      if (location.startsWith('/wallet')) return 3;
      return -1; // Dashboard
    }
    
    final currentIndex = getIndex();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: AppTokens.textSecondary.withValues(alpha: 0.1),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, currentIndex, Icons.people_outline, Icons.people, loc.translate('community'), '/community'),
              _buildNavItem(context, 1, currentIndex, Icons.dynamic_feed_outlined, Icons.dynamic_feed, loc.translate('posts'), '/posts'),
              _buildNavItem(context, 2, currentIndex, Icons.play_lesson_outlined, Icons.play_lesson, loc.translate('my_courses'), '/courses'),
              _buildNavItem(context, 3, currentIndex, Icons.monetization_on_outlined, Icons.monetization_on, loc.translate('withdraw'), '/wallet'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, int currentIndex, IconData icon, IconData activeIcon, String label, String route) {
    final isSelected = index == currentIndex;
    final color = isSelected ? AppTokens.primaryOlive : AppTokens.textSecondary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glowColor = isDark ? AppTokens.accentGlow : AppTokens.primaryOlive;
    
    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(AppTokens.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: AppTokens.durationShort,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? glowColor.withValues(alpha: 0.15) : const Color(0x00000000),
              ),
              child: Icon(isSelected ? activeIcon : icon, color: isSelected ? glowColor : color, size: 24),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? glowColor : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
