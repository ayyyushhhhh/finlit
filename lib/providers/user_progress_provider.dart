import 'package:flutter/material.dart';
import 'package:finlit/firebase/database/database_service.dart';
import 'package:finlit/models/user_progress_model.dart';

class UserProgressProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  List<UserProgressModel> _userProgress = [];
  bool _isLoading = false;

  List<UserProgressModel> get userProgress => _userProgress;
  bool get isLoading => _isLoading;

  Future<void> loadUserProgress(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _userProgress = await _dbService.getUserProgress(userId);
    } catch (e) {
      debugPrint('Error loading progress: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveQuizResult(
    String userId,
    String lessonId,
    int score,
    int totalQuestions,
  ) async {
    try {
      final existing = _userProgress
          .where((p) => p.lessonId == lessonId)
          .toList();
      final percentage = ((score / totalQuestions) * 100).round();
      final now = DateTime.now();

      if (existing.isNotEmpty) {
        final progress = existing.first;
        final updatedProgress = progress.copyWith(
          quizScore: percentage,
          attemptsCount: progress.attemptsCount + 1,
          isCompleted: true,
          completedAt: progress.completedAt ?? now,
          lastAttemptAt: now,
        );

        await _dbService.updateUserProgress(
          progress.progressId!,
          updatedProgress.toMap(),
        );

        final index = _userProgress.indexOf(progress);
        _userProgress[index] = updatedProgress;
      } else {
        final newProgress = UserProgressModel(
          userId: userId,
          lessonId: lessonId,
          isCompleted: true,
          quizScore: percentage,
          attemptsCount: 1,
          completedAt: now,
          lastAttemptAt: now,
        );

        final docId = await _dbService.addUserProgress(newProgress);
        _userProgress.add(newProgress.copyWith(progressId: docId));
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving quiz result: $e');
    }
  }

  bool isLessonCompleted(String lessonId) {
    return _userProgress.any((p) => p.lessonId == lessonId && p.isCompleted);
  }

  int getLessonScore(String lessonId) {
    final progress = _userProgress
        .where((p) => p.lessonId == lessonId)
        .toList();
    if (progress.isEmpty) return 0;
    return progress.first.quizScore;
  }

  int getCompletedLessonsCount() {
    return _userProgress.where((p) => p.isCompleted).length;
  }

  int getTotalPoints() {
    return _userProgress.fold(0, (sum, p) => sum + p.quizScore);
  }

  double getAverageScore() {
    final completed = _userProgress.where((p) => p.isCompleted).toList();
    if (completed.isEmpty) return 0;
    final totalScore = completed.fold(0, (sum, p) => sum + p.quizScore);
    return totalScore / completed.length;
  }

  int getCategoryCompletedCount(String categoryId, List<String> lessonIds) {
    return lessonIds.where((id) => isLessonCompleted(id)).length;
  }

  double getCategoryAverageScore(List<String> lessonIds) {
    final completed = _userProgress
        .where((p) => lessonIds.contains(p.lessonId) && p.isCompleted)
        .toList();
    if (completed.isEmpty) return 0;
    final totalScore = completed.fold(0, (sum, p) => sum + p.quizScore);
    return totalScore / completed.length;
  }
}
