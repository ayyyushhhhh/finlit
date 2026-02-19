import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/constants/app_constants.dart';

class AgeInputScreen extends StatefulWidget {
  const AgeInputScreen({super.key});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                // Welcome message
                Text(
                  'Welcome, ${(auth.currentUser?.displayName ?? 'there').split(' ').first}! \u{1F44B}',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'One quick thing – how old are you?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppConstants.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'This helps us personalize your learning experience.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Age input
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: const InputDecoration(
                    hintText: 'Enter your age',
                    prefixIcon: Icon(Icons.cake_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null) {
                      return 'Please enter a valid number';
                    }
                    if (age < 14 || age > 21) {
                      return 'Age must be between 14 and 21';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Age must be between 14 and 21',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppConstants.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitAge,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Continue'),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitAge() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final age = int.parse(_ageController.text);
    await context.read<AuthProvider>().updateUserAge(age);
    if (mounted) setState(() => _isLoading = false);
  }
}
