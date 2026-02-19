import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/theme_provider.dart';
import 'package:finlit/constants/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final user = auth.currentUser;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Profile photo
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user?.displayName ?? 'User',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user?.age != null) ...[
                  Chip(
                    label: Text('Age: ${user!.age}'),
                    backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: AppConstants.primaryColor),
                  ),
                  const SizedBox(width: 8),
                ],
                Chip(
                  label: Text(
                    'Member since ${DateFormat('MMM yyyy').format(user?.createdAt ?? DateTime.now())}',
                  ),
                  backgroundColor: AppConstants.secondaryColor.withOpacity(0.1),
                  labelStyle: TextStyle(color: AppConstants.secondaryColor),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Settings
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (_) => themeProvider.toggleTheme(),
                      activeThumbColor: AppConstants.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Actions
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: AppConstants.accentRed,
                    ),
                    title: const Text('Sign Out'),
                    onTap: () => _showSignOutDialog(context),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.delete_forever,
                      color: Colors.red.shade700,
                    ),
                    title: Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                    onTap: () => _showDeleteDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // App info
            Text(
              'FinLit v1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppConstants.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Financial Literacy for Teens',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppConstants.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthProvider>().signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.accentRed,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This will permanently delete your account and all data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthProvider>().deleteAccount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
