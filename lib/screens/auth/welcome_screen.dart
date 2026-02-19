import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/constants/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // App Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 60,
                  color: AppConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 32),
              // App Name
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppConstants.tagline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppConstants.textSecondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 48),
              // Feature highlights
              _buildFeatureItem(
                context,
                Icons.school_outlined,
                'Learn financial basics with bite-sized lessons',
              ),
              const SizedBox(height: 12),
              _buildFeatureItem(
                context,
                Icons.calculate_outlined,
                'Budget simulators & savings calculators',
              ),
              const SizedBox(height: 12),
              _buildFeatureItem(
                context,
                Icons.emoji_events_outlined,
                'Track progress & earn achievement points',
              ),
              const SizedBox(height: 12),
              _buildFeatureItem(
                context,
                Icons.quiz_outlined,
                'Test knowledge with interactive quizzes',
              ),
              const Spacer(flex: 2),
              // Sign in button
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: auth.status == AuthStatus.authenticating
                          ? null
                          : () => _signIn(context),
                      icon: auth.status == AuthStatus.authenticating
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.login, size: 20),
                      label: Text(
                        auth.status == AuthStatus.authenticating
                            ? 'Signing in...'
                            : 'Sign in with Google',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                'By signing in, you agree to our Terms of Service',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppConstants.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppConstants.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppConstants.primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppConstants.textPrimary),
          ),
        ),
      ],
    );
  }

  Future<void> _signIn(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final success = await auth.signInWithGoogle();
    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in failed. Please try again.'),
          backgroundColor: AppConstants.accentRed,
        ),
      );
    }
  }
}
