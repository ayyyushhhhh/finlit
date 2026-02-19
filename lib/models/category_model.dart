import 'package:flutter/material.dart';
import 'package:finlit/models/lesson_model.dart';

class CategoryModel {
  final String categoryId;
  final String title;
  final String description;
  final IconData icon;
  final Color themeColor;
  final int orderIndex;
  final List<LessonModel> lessons;

  const CategoryModel({
    required this.categoryId,
    required this.title,
    required this.description,
    required this.icon,
    required this.themeColor,
    required this.orderIndex,
    required this.lessons,
  });
}
