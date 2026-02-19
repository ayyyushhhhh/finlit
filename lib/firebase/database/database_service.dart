import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlit/models/user_model.dart';
import 'package:finlit/models/user_progress_model.dart';
import 'package:finlit/models/budget_simulation_model.dart';
import 'package:finlit/models/savings_goal_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ─── Users ──────────────────────────────────────────────────────────────

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!);
  }

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  // ─── User Progress ─────────────────────────────────────────────────────

  Future<List<UserProgressModel>> getUserProgress(String userId) async {
    final snapshot = await _firestore
        .collection('user_progress')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => UserProgressModel.fromMap(doc.data(), id: doc.id))
        .toList();
  }

  Future<String> addUserProgress(UserProgressModel progress) async {
    final docRef = await _firestore
        .collection('user_progress')
        .add(progress.toMap());
    return docRef.id;
  }

  Future<void> updateUserProgress(
    String progressId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection('user_progress').doc(progressId).update(data);
  }

  // ─── Budget Simulations ────────────────────────────────────────────────

  Future<String> addBudgetSimulation(BudgetSimulationModel simulation) async {
    final docRef = await _firestore
        .collection('budget_simulations')
        .add(simulation.toMap());
    return docRef.id;
  }

  Future<List<BudgetSimulationModel>> getBudgetSimulations(
    String userId,
  ) async {
    final snapshot = await _firestore
        .collection('budget_simulations')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return snapshot.docs
        .map((doc) => BudgetSimulationModel.fromMap(doc.data(), id: doc.id))
        .toList();
  }

  // ─── Savings Goals ─────────────────────────────────────────────────────

  Future<String> addSavingsGoal(SavingsGoalModel goal) async {
    final docRef = await _firestore
        .collection('savings_goals')
        .add(goal.toMap());
    return docRef.id;
  }

  Future<List<SavingsGoalModel>> getSavingsGoals(String userId) async {
    final snapshot = await _firestore
        .collection('savings_goals')
        .where('userId', isEqualTo: userId)
        .where('isActive', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((doc) => SavingsGoalModel.fromMap(doc.data(), id: doc.id))
        .toList();
  }
}
