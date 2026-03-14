import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/screens/auth/welcome_screen.dart';
import 'package:finlit/screens/auth/age_input_screen.dart';
import 'package:finlit/screens/home/home_screen.dart';
import 'package:finlit/screens/learn/learn_screen.dart';
import 'package:finlit/screens/calculators/calculators_screen.dart';
import 'package:finlit/screens/progress/progress_screen.dart';
import 'package:finlit/screens/profile/profile_screen.dart';
import 'package:finlit/screens/main_navigation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

class AppRouter {
  static GoRouter router(AuthProvider authProvider) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/welcome',
      refreshListenable: authProvider,
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Page Not Found'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.go('/welcome'),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
      redirect: (context, state) {
        final isLoggedIn = authProvider.status == AuthStatus.authenticated;
        final isAuthScreen =
            state.matchedLocation == '/' || state.matchedLocation == '/welcome';

        if (authProvider.status == AuthStatus.uninitialized ||
            authProvider.status == AuthStatus.authenticating) {
          return null;
        }

        if (!isLoggedIn) {
          return '/welcome';
        }

        if (isLoggedIn &&
            authProvider.needsAge &&
            state.matchedLocation != '/age_input') {
          return '/age_input';
        }

        if (isLoggedIn && isAuthScreen) {
          return '/home';
        }

        return null;
      },
      routes: [
        GoRoute(path: '/', redirect: (context, state) => '/welcome'),
        GoRoute(
          path: '/welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/age_input',
          builder: (context, state) => const AgeInputScreen(),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return MainNavigation(child: child); // Pass the current child
          },
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/learn',
              builder: (context, state) => const LearnScreen(),
            ),
            GoRoute(
              path: '/calculators',
              builder: (context, state) => const CalculatorsScreen(),
            ),
            GoRoute(
              path: '/progress',
              builder: (context, state) => const ProgressScreen(),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
