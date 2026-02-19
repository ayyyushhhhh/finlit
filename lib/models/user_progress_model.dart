import 'package:cloud_firestore/cloud_firestore.dart';

class UserProgressModel {
  final String? progressId;
  final String userId;
  final String lessonId;
  final bool isCompleted;
  final int quizScore;
  final int attemptsCount;
  final DateTime? completedAt;
  final DateTime? lastAttemptAt;

  UserProgressModel({
    this.progressId,
    required this.userId,
    required this.lessonId,
    this.isCompleted = false,
    this.quizScore = 0,
    this.attemptsCount = 0,
    this.completedAt,
    this.lastAttemptAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'lessonId': lessonId,
      'isCompleted': isCompleted,
      'quizScore': quizScore,
      'attemptsCount': attemptsCount,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'lastAttemptAt': lastAttemptAt != null ? Timestamp.fromDate(lastAttemptAt!) : null,
    };
  }

  factory UserProgressModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return UserProgressModel(
      progressId: id,
      userId: map['userId'] ?? '',
      lessonId: map['lessonId'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      quizScore: map['quizScore'] ?? 0,
      attemptsCount: map['attemptsCount'] ?? 0,
      completedAt: (map['completedAt'] as Timestamp?)?.toDate(),
      lastAttemptAt: (map['lastAttemptAt'] as Timestamp?)?.toDate(),
    );
  }

  UserProgressModel copyWith({
    String? progressId,
    String? userId,
    String? lessonId,
    bool? isCompleted,
    int? quizScore,
    int? attemptsCount,
    DateTime? completedAt,
    DateTime? lastAttemptAt,
  }) {
    return UserProgressModel(
      progressId: progressId ?? this.progressId,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      quizScore: quizScore ?? this.quizScore,
      attemptsCount: attemptsCount ?? this.attemptsCount,
      completedAt: completedAt ?? this.completedAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
    );
  }
}
