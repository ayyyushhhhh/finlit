import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/lesson_provider.dart';
import 'package:finlit/providers/user_progress_provider.dart';
import 'package:finlit/constants/app_constants.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final lessonProvider = context.watch<LessonProvider>();
    final progressProvider = context.watch<UserProgressProvider>();
    final user = auth.currentUser;

    final completedCount = progressProvider.getCompletedLessonsCount();
    final totalLessons = lessonProvider.totalLessons;
    final avgScore = progressProvider.getAverageScore();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Progress',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),

            // Stats overview
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.emoji_events,
                    value: '${user?.totalPoints ?? 0}',
                    label: 'Points',
                    color: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.local_fire_department,
                    value: '${user?.currentStreak ?? 0}',
                    label: 'Streak',
                    color: AppConstants.budgetingColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.star,
                    value: '${user?.longestStreak ?? 0}',
                    label: 'Best',
                    color: AppConstants.secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.menu_book,
                    value: '$completedCount/$totalLessons',
                    label: 'Lessons',
                    color: AppConstants.investingColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.quiz,
                    value: '${avgScore.toStringAsFixed(0)}%',
                    label: 'Avg Score',
                    color: AppConstants.creditColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Category-wise progress
            Text(
              'Category Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...lessonProvider.categories.map((category) {
              final lessonIds = category.lessons
                  .map((l) => l.lessonId)
                  .toList();
              final categoryCompleted = progressProvider
                  .getCategoryCompletedCount(category.categoryId, lessonIds);
              final categoryTotal = category.lessons.length;
              final categoryAvg = progressProvider.getCategoryAverageScore(
                lessonIds,
              );
              final progress = categoryTotal > 0
                  ? categoryCompleted / categoryTotal
                  : 0.0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: category.themeColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                category.icon,
                                color: category.themeColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                category.title,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            Text(
                              '$categoryCompleted/$categoryTotal',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: category.themeColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              category.themeColor,
                            ),
                          ),
                        ),
                        if (categoryCompleted > 0) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Average quiz score: ${categoryAvg.toStringAsFixed(0)}%',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppConstants.textSecondary),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),

            // Quiz history
            Text('Quiz History', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            if (progressProvider.userProgress.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.quiz_outlined,
                          size: 48,
                          color: AppConstants.textSecondary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No quizzes taken yet',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppConstants.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Start a lesson to take your first quiz!',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ...progressProvider.userProgress.where((p) => p.isCompleted).map((
                progress,
              ) {
                try {
                  final lesson = lessonProvider.getLessonById(
                    progress.lessonId,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: progress.quizScore >= 80
                              ? AppConstants.secondaryColor.withOpacity(0.1)
                              : AppConstants.budgetingColor.withOpacity(0.1),
                          child: Text(
                            '${progress.quizScore}%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: progress.quizScore >= 80
                                  ? AppConstants.secondaryColor
                                  : AppConstants.budgetingColor,
                            ),
                          ),
                        ),
                        title: Text(
                          lesson.title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        subtitle: Text(
                          'Attempts: ${progress.attemptsCount}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: progress.quizScore >= 80
                            ? const Icon(
                                Icons.check_circle,
                                color: AppConstants.secondaryColor,
                              )
                            : const Icon(
                                Icons.refresh,
                                color: AppConstants.budgetingColor,
                                size: 20,
                              ),
                      ),
                    ),
                  );
                } catch (_) {
                  return const SizedBox.shrink();
                }
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
