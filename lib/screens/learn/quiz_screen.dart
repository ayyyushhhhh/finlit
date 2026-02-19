import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finlit/models/lesson_model.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/user_progress_provider.dart';
import 'package:finlit/constants/app_constants.dart';

class QuizScreen extends StatefulWidget {
  final LessonModel lesson;

  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _hasAnswered = false;
  int _correctAnswers = 0;
  bool _quizComplete = false;

  @override
  Widget build(BuildContext context) {
    if (_quizComplete) {
      return _buildResultScreen(context);
    }

    final question = widget.lesson.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Quiz'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${_currentQuestionIndex + 1}/${widget.lesson.questions.length}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value:
                    (_currentQuestionIndex + 1) /
                    widget.lesson.questions.length,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppConstants.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Question
            Text(
              'Question ${_currentQuestionIndex + 1}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              question.questionText,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            // Options
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isCorrect = index == question.correctAnswerIndex;
              final isSelected = index == _selectedOptionIndex;

              Color? bgColor;
              Color? borderColor;
              Color? textColor;

              if (_hasAnswered) {
                if (isCorrect) {
                  bgColor = AppConstants.secondaryColor.withOpacity(0.1);
                  borderColor = AppConstants.secondaryColor;
                  textColor = AppConstants.secondaryColor;
                } else if (isSelected && !isCorrect) {
                  bgColor = AppConstants.accentRed.withOpacity(0.1);
                  borderColor = AppConstants.accentRed;
                  textColor = AppConstants.accentRed;
                }
              } else if (isSelected) {
                bgColor = AppConstants.primaryColor.withOpacity(0.1);
                borderColor = AppConstants.primaryColor;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: _hasAnswered
                      ? null
                      : () => setState(() => _selectedOptionIndex = index),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor ?? Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColor ?? Colors.grey.shade300,
                        width: isSelected || (_hasAnswered && isCorrect)
                            ? 2
                            : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? (borderColor ?? AppConstants.primaryColor)
                                : Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : AppConstants.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: textColor ?? AppConstants.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : null,
                                ),
                          ),
                        ),
                        if (_hasAnswered && isCorrect)
                          const Icon(
                            Icons.check_circle,
                            color: AppConstants.secondaryColor,
                            size: 24,
                          ),
                        if (_hasAnswered && isSelected && !isCorrect)
                          const Icon(
                            Icons.cancel,
                            color: AppConstants.accentRed,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Explanation
            if (_hasAnswered) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue.shade700,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Explanation',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: Colors.blue.shade700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.explanation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const Spacer(),

            // Action button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedOptionIndex == null
                    ? null
                    : _hasAnswered
                    ? _nextQuestion
                    : _submitAnswer,
                child: Text(
                  _hasAnswered
                      ? (_currentQuestionIndex <
                                widget.lesson.questions.length - 1
                            ? 'Next Question'
                            : 'See Results')
                      : 'Submit Answer',
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _submitAnswer() {
    final question = widget.lesson.questions[_currentQuestionIndex];
    final isCorrect = _selectedOptionIndex == question.correctAnswerIndex;
    if (isCorrect) _correctAnswers++;
    setState(() => _hasAnswered = true);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.lesson.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _hasAnswered = false;
      });
    } else {
      // Quiz complete, save results
      _saveResults();
      setState(() => _quizComplete = true);
    }
  }

  Future<void> _saveResults() async {
    final auth = context.read<AuthProvider>();
    final progress = context.read<UserProgressProvider>();
    if (auth.currentUser != null) {
      await progress.saveQuizResult(
        auth.currentUser!.uid,
        widget.lesson.lessonId,
        _correctAnswers,
        widget.lesson.questions.length,
      );
      // Update points
      final pointsEarned =
          _correctAnswers * AppConstants.pointsPerCorrectAnswer +
          AppConstants.pointsPerLessonComplete;
      await auth.updatePoints(pointsEarned);
    }
  }

  Widget _buildResultScreen(BuildContext context) {
    final total = widget.lesson.questions.length;
    final percentage = ((_correctAnswers / total) * 100).round();
    final passed = percentage >= 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: passed
                      ? AppConstants.secondaryColor.withOpacity(0.1)
                      : AppConstants.accentRed.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  passed ? Icons.emoji_events : Icons.refresh,
                  size: 50,
                  color: passed
                      ? AppConstants.secondaryColor
                      : AppConstants.accentRed,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                passed ? 'Great Job! 🎉' : 'Keep Learning! 💪',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'You scored',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppConstants.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$_correctAnswers/$total',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: passed
                      ? AppConstants.secondaryColor
                      : AppConstants.accentRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppConstants.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Points earned: ${_correctAnswers * AppConstants.pointsPerCorrectAnswer + AppConstants.pointsPerLessonComplete}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Back to Home'),
                ),
              ),
              const SizedBox(height: 12),
              if (!passed)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex = 0;
                        _selectedOptionIndex = null;
                        _hasAnswered = false;
                        _correctAnswers = 0;
                        _quizComplete = false;
                      });
                    },
                    child: const Text('Retake Quiz'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
