import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/lesson_provider.dart';
import 'package:finlit/providers/user_progress_provider.dart';
import 'package:finlit/constants/app_constants.dart';
import 'package:finlit/screens/learn/category_lessons_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final lessonProvider = context.watch<LessonProvider>();
    final progressProvider = context.watch<UserProgressProvider>();
    final user = auth.currentUser;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  child: user?.photoURL == null
                      ? const Icon(Icons.person, size: 24)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${(user?.displayName ?? 'there').split(' ').first}!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Ready to learn today?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                // Streak badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      Text(
                        '${user?.currentStreak ?? 0}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppConstants.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Stats Card
            _buildQuickStatsCard(context, lessonProvider, progressProvider),
            const SizedBox(height: 24),

            // Learning Categories
            Text(
              'Learning Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildCategoryGrid(context, lessonProvider, progressProvider),
            const SizedBox(height: 24),

            // Points badge
            _buildPointsBadge(context, user?.totalPoints ?? 0),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsCard(
    BuildContext context,
    LessonProvider lessonProvider,
    UserProgressProvider progressProvider,
  ) {
    final completed = progressProvider.getCompletedLessonsCount();
    final total = lessonProvider.totalLessons;
    final progress = total > 0 ? completed / total : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$completed/$total',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: AppConstants.primaryColor),
                      ),
                      Text(
                        'Lessons\nCompleted',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 12,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppConstants.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(progress * 100).toStringAsFixed(0)}% Complete',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${progressProvider.getAverageScore().toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: AppConstants.secondaryColor),
                      ),
                      Text(
                        'Avg Quiz\nScore',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(
    BuildContext context,
    LessonProvider lessonProvider,
    UserProgressProvider progressProvider,
  ) {
    final categories = lessonProvider.categories;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final lessonIds = category.lessons.map((l) => l.lessonId).toList();
        final completedCount = progressProvider.getCategoryCompletedCount(
          category.categoryId,
          lessonIds,
        );
        final totalLessons = category.lessons.length;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryLessonsScreen(category: category),
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: category.themeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      category.icon,
                      color: category.themeColor,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    category.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completedCount/$totalLessons lessons',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppConstants.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: totalLessons > 0
                          ? completedCount / totalLessons
                          : 0,
                      minHeight: 5,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        category.themeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPointsBadge(BuildContext context, int points) {
    return Card(
      color: AppConstants.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Points',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  Text(
                    '$points',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // const Icon(Icons.arrow_forward_ios, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
