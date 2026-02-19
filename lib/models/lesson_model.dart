import 'package:finlit/models/question_model.dart';

class LessonModel {
  final String lessonId;
  final String categoryId;
  final String title;
  final String content;
  final String example;
  final int estimatedMinutes;
  final int orderIndex;
  final List<QuestionModel> questions;

  const LessonModel({
    required this.lessonId,
    required this.categoryId,
    required this.title,
    required this.content,
    required this.example,
    required this.estimatedMinutes,
    required this.orderIndex,
    required this.questions,
  });
}
