import 'package:cloud_firestore/cloud_firestore.dart';

class SavingsGoalModel {
  final String? goalId;
  final String userId;
  final String goalName;
  final double targetAmount;
  final double monthlySaving;
  final double interestRate;
  final int monthsRequired;
  final double totalWithInterest;
  final DateTime createdAt;
  final bool isActive;

  SavingsGoalModel({
    this.goalId,
    required this.userId,
    required this.goalName,
    required this.targetAmount,
    required this.monthlySaving,
    this.interestRate = 6.0,
    required this.monthsRequired,
    required this.totalWithInterest,
    required this.createdAt,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'goalName': goalName,
      'targetAmount': targetAmount,
      'monthlySaving': monthlySaving,
      'interestRate': interestRate,
      'monthsRequired': monthsRequired,
      'totalWithInterest': totalWithInterest,
      'createdAt': Timestamp.fromDate(createdAt),
      'isActive': isActive,
    };
  }

  factory SavingsGoalModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return SavingsGoalModel(
      goalId: id,
      userId: map['userId'] ?? '',
      goalName: map['goalName'] ?? '',
      targetAmount: (map['targetAmount'] ?? 0).toDouble(),
      monthlySaving: (map['monthlySaving'] ?? 0).toDouble(),
      interestRate: (map['interestRate'] ?? 6.0).toDouble(),
      monthsRequired: map['monthsRequired'] ?? 0,
      totalWithInterest: (map['totalWithInterest'] ?? 0).toDouble(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: map['isActive'] ?? true,
    );
  }
}
