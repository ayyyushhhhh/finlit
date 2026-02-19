import 'package:cloud_firestore/cloud_firestore.dart';

class BudgetSimulationModel {
  final String? simulationId;
  final String userId;
  final double fictionalIncome;
  final Map<String, double> allocations;
  final double remainingBalance;
  final int healthScore;
  final DateTime createdAt;

  BudgetSimulationModel({
    this.simulationId,
    required this.userId,
    required this.fictionalIncome,
    required this.allocations,
    required this.remainingBalance,
    required this.healthScore,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fictionalIncome': fictionalIncome,
      'allocations': allocations,
      'remainingBalance': remainingBalance,
      'healthScore': healthScore,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory BudgetSimulationModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return BudgetSimulationModel(
      simulationId: id,
      userId: map['userId'] ?? '',
      fictionalIncome: (map['fictionalIncome'] ?? 0).toDouble(),
      allocations: Map<String, double>.from(
        (map['allocations'] as Map<String, dynamic>? ?? {}).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),
      remainingBalance: (map['remainingBalance'] ?? 0).toDouble(),
      healthScore: map['healthScore'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
