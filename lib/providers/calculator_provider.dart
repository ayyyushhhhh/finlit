import 'dart:math';
import 'package:flutter/material.dart';
import 'package:finlit/firebase/database/database_service.dart';
import 'package:finlit/models/savings_goal_model.dart';
import 'package:finlit/constants/app_constants.dart';

class CalculatorProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  List<SavingsGoalModel> _savedGoals = [];

  List<SavingsGoalModel> get savedGoals => _savedGoals;

  // ─── Savings Goal Calculator ──────────────────────────────────────────

  SavingsGoalModel calculateSavingsGoal({
    required String userId,
    required String goalName,
    required double targetAmount,
    required double monthlySaving,
    double interestRate = AppConstants.defaultInterestRate,
  }) {
    int months = 0;
    double totalSaved = 0;
    final monthlyRate = interestRate / 12 / 100;

    if (interestRate > 0) {
      // With compound interest
      while (totalSaved < targetAmount && months < 1200) {
        totalSaved = totalSaved * (1 + monthlyRate) + monthlySaving;
        months++;
      }
    } else {
      // Without interest
      months = (targetAmount / monthlySaving).ceil();
      totalSaved = monthlySaving * months;
    }

    return SavingsGoalModel(
      userId: userId,
      goalName: goalName,
      targetAmount: targetAmount,
      monthlySaving: monthlySaving,
      interestRate: interestRate,
      monthsRequired: months,
      totalWithInterest: totalSaved,
      createdAt: DateTime.now(),
    );
  }

  // ─── Inflation Calculator ─────────────────────────────────────────────

  Map<String, dynamic> calculateInflation({
    required double currentPrice,
    required int years,
    required double inflationRate,
  }) {
    final futurePrice = currentPrice * pow(1 + inflationRate / 100, years);
    final priceIncrease = futurePrice - currentPrice;
    final percentageIncrease = (priceIncrease / currentPrice) * 100;

    return {
      'futurePrice': futurePrice,
      'priceIncrease': priceIncrease,
      'percentageIncrease': percentageIncrease,
      'currentPrice': currentPrice,
      'years': years,
      'inflationRate': inflationRate,
    };
  }

  // ─── Firestore operations ─────────────────────────────────────────────

  Future<void> saveSavingsGoal(SavingsGoalModel goal) async {
    try {
      final docId = await _dbService.addSavingsGoal(goal);
      _savedGoals.insert(
        0,
        SavingsGoalModel(
          goalId: docId,
          userId: goal.userId,
          goalName: goal.goalName,
          targetAmount: goal.targetAmount,
          monthlySaving: goal.monthlySaving,
          interestRate: goal.interestRate,
          monthsRequired: goal.monthsRequired,
          totalWithInterest: goal.totalWithInterest,
          createdAt: goal.createdAt,
        ),
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving goal: $e');
    }
  }

  Future<void> loadSavedGoals(String userId) async {
    try {
      _savedGoals = await _dbService.getSavingsGoals(userId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading goals: $e');
    }
  }
}
