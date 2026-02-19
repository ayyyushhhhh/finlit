import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:finlit/constants/app_theme.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/lesson_provider.dart';
import 'package:finlit/providers/user_progress_provider.dart';
import 'package:finlit/providers/budget_simulator_provider.dart';
import 'package:finlit/providers/calculator_provider.dart';
import 'package:finlit/providers/theme_provider.dart';
import 'package:finlit/screens/auth/welcome_screen.dart';
import 'package:finlit/screens/auth/age_input_screen.dart';
import 'package:finlit/screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'FinLit',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    switch (auth.status) {
      case AuthStatus.uninitialized:
      case AuthStatus.authenticating:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthStatus.unauthenticated:
        return const WelcomeScreen();
      case AuthStatus.authenticated:
        if (auth.needsAge) {
          return const AgeInputScreen();
        }
        return const MainNavigation();
    }
  }
}
