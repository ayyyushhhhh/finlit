import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finlit/models/category_model.dart';
import 'package:finlit/providers/user_progress_provider.dart';
import 'package:finlit/constants/app_constants.dart';
import 'package:finlit/screens/learn/lesson_detail_screen.dart';

class CategoryLessonsScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryLessonsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<UserProgressProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    category.themeColor,
                    category.themeColor.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(category.icon, color: Colors.white, size: 40),
                  const SizedBox(height: 12),
                  Text(
                    category.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${category.lessons.length} lessons',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Lessons list
            Text('Lessons', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...category.lessons.asMap().entries.map((entry) {
              final index = entry.key;
              final lesson = entry.value;
              final isCompleted = progressProvider.isLessonCompleted(
                lesson.lessonId,
              );
              final score = progressProvider.getLessonScore(lesson.lessonId);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonDetailScreen(lesson: lesson),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Lesson number circle
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppConstants.secondaryColor
                                  : category.themeColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: category.themeColor,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lesson.title,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: 14,
                                      color: AppConstants.textSecondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${lesson.estimatedMinutes} min',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                    if (isCompleted) ...[
                                      const SizedBox(width: 12),
                                      Icon(
                                        Icons.quiz_outlined,
                                        size: 14,
                                        color: AppConstants.textSecondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Score: $score%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: score >= 80
                                                  ? AppConstants.secondaryColor
                                                  : AppConstants.textSecondary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: AppConstants.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
