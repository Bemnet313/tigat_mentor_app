import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/localization/localization_provider.dart';
import 'core/router/app_router.dart';
import 'features/posts/providers/posts_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PostsProvider()),
      ],
      child: const TigatMentorApp(),
    ),
  );
}

class TigatMentorApp extends StatelessWidget {
  const TigatMentorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = context.watch<LocalizationProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      title: 'Tigat Mentor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: Locale(localizationProvider.currentLocale),
      routerConfig: AppRouter.router,
    );
  }
}
