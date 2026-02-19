import 'package:flutter/material.dart';
import 'package:finlit/models/category_model.dart';
import 'package:finlit/models/lesson_model.dart';
import 'package:finlit/data/lesson_data.dart';

class LessonProvider extends ChangeNotifier {
  final List<CategoryModel> _categories = LessonData.getAllCategories();
  LessonModel? _currentLesson;

  List<CategoryModel> get categories => _categories;
  LessonModel? get currentLesson => _currentLesson;

  int get totalLessons {
    return _categories.fold(0, (sum, cat) => sum + cat.lessons.length);
  }

  List<LessonModel> get allLessons {
    return _categories.expand((cat) => cat.lessons).toList();
  }

  CategoryModel getCategoryById(String id) {
    return _categories.firstWhere((cat) => cat.categoryId == id);
  }

  LessonModel getLessonById(String lessonId) {
    for (final category in _categories) {
      for (final lesson in category.lessons) {
        if (lesson.lessonId == lessonId) return lesson;
      }
    }
    throw Exception('Lesson not found: $lessonId');
  }

  void setCurrentLesson(LessonModel lesson) {
    _currentLesson = lesson;
    notifyListeners();
  }

  LessonModel? getNextLesson(String currentLessonId) {
    final allLessonsList = allLessons;
    final currentIndex = allLessonsList.indexWhere((l) => l.lessonId == currentLessonId);
    if (currentIndex >= 0 && currentIndex < allLessonsList.length - 1) {
      return allLessonsList[currentIndex + 1];
    }
    return null;
  }

  List<LessonModel> getLessonsForCategory(String categoryId) {
    return _categories
        .firstWhere((cat) => cat.categoryId == categoryId)
        .lessons;
  }
}
