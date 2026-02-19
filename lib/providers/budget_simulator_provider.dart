import 'package:flutter/material.dart';
import 'package:finlit/firebase/database/database_service.dart';
import 'package:finlit/models/budget_simulation_model.dart';
import 'package:finlit/constants/app_constants.dart';

class BudgetSimulatorProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  final double _fictionalIncome = AppConstants.defaultIncome;
  Map<String, double> _allocations = {
    'rent': AppConstants.defaultRent,
    'food': AppConstants.defaultFood,
    'transport': AppConstants.defaultTransport,
    'entertainment': AppConstants.defaultEntertainment,
    'savings': AppConstants.defaultSavings,
  };

  List<BudgetSimulationModel> _savedBudgets = [];

  double get fictionalIncome => _fictionalIncome;
  Map<String, double> get allocations => Map.unmodifiable(_allocations);
  List<BudgetSimulationModel> get savedBudgets => _savedBudgets;

  double get totalAllocated {
    return _allocations.values.fold(0.0, (sum, val) => sum + val);
  }

  double get remainingBalance {
    return _fictionalIncome - totalAllocated;
  }

  bool get isOverspent => remainingBalance < 0;

  void updateAllocation(String category, double amount) {
    _allocations[category] = amount;
    notifyListeners();
  }

  void resetAllocations() {
    _allocations = {
      'rent': AppConstants.defaultRent,
      'food': AppConstants.defaultFood,
      'transport': AppConstants.defaultTransport,
      'entertainment': AppConstants.defaultEntertainment,
      'savings': AppConstants.defaultSavings,
    };
    notifyListeners();
  }

  int calculateHealthScore() {
    if (isOverspent) return 0;

    double score = 0;
    final savingsPercentage =
        (_allocations['savings'] ?? 0) / _fictionalIncome * 100;

    // Savings weight (40 points)
    if (savingsPercentage >= 20) {
      score += 40;
    } else if (savingsPercentage >= 10) {
      score += 25;
    } else if (savingsPercentage >= 5) {
      score += 15;
    } else {
      score += 5;
    }

    // Balance weight (30 points)
    final balancePercentage = remainingBalance / _fictionalIncome * 100;
    if (balancePercentage >= 10) {
      score += 30;
    } else if (balancePercentage >= 5) {
      score += 20;
    } else if (balancePercentage >= 0) {
      score += 10;
    }

    // Needs vs Wants ratio (30 points)
    final needsTotal =
        (_allocations['rent'] ?? 0) +
        (_allocations['food'] ?? 0) +
        (_allocations['transport'] ?? 0);
    final needsPercentage = needsTotal / _fictionalIncome * 100;
    if (needsPercentage <= 50) {
      score += 30;
    } else if (needsPercentage <= 60) {
      score += 20;
    } else if (needsPercentage <= 70) {
      score += 10;
    }

    return score.round().clamp(0, 100);
  }

  String getHealthLabel(int score) {
    if (score >= 80) return 'Excellent';
    if (score >= 60) return 'Good';
    if (score >= 40) return 'Fair';
    return 'Needs Improvement';
  }

  Color getHealthColor(int score) {
    if (score >= 80) return AppConstants.secondaryColor;
    if (score >= 60) return Colors.amber;
    if (score >= 40) return Colors.orange;
    return AppConstants.accentRed;
  }

  String getRecommendation() {
    if (isOverspent) {
      return 'You\'re overspending! Reduce your allocations to fit within your income.';
    }

    final savingsPercentage =
        (_allocations['savings'] ?? 0) / _fictionalIncome * 100;
    if (savingsPercentage < 20) {
      return 'Consider increasing your savings to at least 20% of your income.';
    }

    final healthScore = calculateHealthScore();
    if (healthScore >= 80) {
      return 'Great job! Your budget looks healthy and well-balanced.';
    }

    return 'Your budget is reasonable. Try to optimize by reducing wants and increasing savings.';
  }

  Future<void> saveBudgetSimulation(String userId) async {
    try {
      final simulation = BudgetSimulationModel(
        userId: userId,
        fictionalIncome: _fictionalIncome,
        allocations: Map.from(_allocations),
        remainingBalance: remainingBalance,
        healthScore: calculateHealthScore(),
        createdAt: DateTime.now(),
      );

      final docId = await _dbService.addBudgetSimulation(simulation);
      _savedBudgets.insert(
        0,
        BudgetSimulationModel(
          simulationId: docId,
          userId: simulation.userId,
          fictionalIncome: simulation.fictionalIncome,
          allocations: simulation.allocations,
          remainingBalance: simulation.remainingBalance,
          healthScore: simulation.healthScore,
          createdAt: simulation.createdAt,
        ),
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving budget: $e');
    }
  }

  Future<void> loadSavedBudgets(String userId) async {
    try {
      _savedBudgets = await _dbService.getBudgetSimulations(userId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading budgets: $e');
    }
  }
}
