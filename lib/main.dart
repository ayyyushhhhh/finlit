import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:finlit/constants/app_theme.dart';
import 'package:finlit/firebase_options.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/lesson_provider.dart';
import 'package:finlit/providers/user_progress_provider.dart';
import 'package:finlit/providers/budget_simulator_provider.dart';
import 'package:finlit/providers/calculator_provider.dart';
import 'package:finlit/providers/theme_provider.dart';
import 'package:finlit/screens/auth/welcome_screen.dart';
import 'package:finlit/screens/auth/age_input_screen.dart';
import 'package:finlit/screens/main_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:finlit/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove hash from URLs on web
  if (kIsWeb) {
    setPathUrlStrategy();
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FinLitApp());
}

class FinLitApp extends StatelessWidget {
  const FinLitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LessonProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProgressProvider()),
        ChangeNotifierProvider(create: (_) => BudgetSimulatorProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
      ],
      child: Consumer2<ThemeProvider, AuthProvider>(
        builder: (context, themeProvider, authProvider, _) {
          return MaterialApp.router(
            title: 'FinEd - Money Made Simple',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: AppRouter.router(authProvider),
          );
        },
      ),
    );
  }
}
