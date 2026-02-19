import 'package:flutter/material.dart';
import 'package:finlit/models/lesson_model.dart';
import 'package:finlit/constants/app_constants.dart';
import 'package:finlit/screens/learn/quiz_screen.dart';

class LessonDetailScreen extends StatelessWidget {
  final LessonModel lesson;

  const LessonDetailScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    lesson.categoryId.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: AppConstants.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${lesson.estimatedMinutes} min read',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              lesson.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),

            // Content
            _buildFormattedContent(context, lesson.content),
            const SizedBox(height: 24),

            // Real-life example
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppConstants.secondaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppConstants.secondaryColor.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppConstants.secondaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Real-Life Example',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppConstants.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    lesson.example,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppConstants.textPrimary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Quiz button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(lesson: lesson),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz_outlined),
                label: Text('Take Quiz (${lesson.questions.length} Questions)'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFormattedContent(BuildContext context, String content) {
    // Simple markdown-like formatting
    final paragraphs = content.split('\n\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((paragraph) {
        // Handle bold text
        if (paragraph.contains('**')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildParagraphWithBold(context, paragraph),
          );
        }
        // Handle bullet points
        if (paragraph.startsWith('•') ||
            paragraph.startsWith('1.') ||
            paragraph.startsWith('2.')) {
          final lines = paragraph.split('\n');
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lines.map((line) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: _buildParagraphWithBold(context, line),
                );
              }).toList(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            paragraph,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: AppConstants.textPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildParagraphWithBold(BuildContext context, String text) {
    final parts = text.split('**');
    if (parts.length <= 1) {
      return Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          height: 1.6,
          color: AppConstants.textPrimary,
        ),
      );
    }
    final spans = <TextSpan>[];
    for (int i = 0; i < parts.length; i++) {
      spans.add(
        TextSpan(
          text: parts[i],
          style: i % 2 == 1
              ? const TextStyle(fontWeight: FontWeight.bold)
              : null,
        ),
      );
    }
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          height: 1.6,
          color: AppConstants.textPrimary,
        ),
        children: spans,
      ),
    );
  }
}
