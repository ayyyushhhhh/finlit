import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlit/firebase/auth/auth_service.dart';
import 'package:finlit/firebase/database/database_service.dart';
import 'package:finlit/models/user_model.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final DatabaseService _dbService = DatabaseService();

  AuthStatus _status = AuthStatus.uninitialized;
  UserModel? _currentUser;

  AuthStatus get status => _status;
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get needsAge => _currentUser != null && _currentUser!.age == null;

  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.unauthenticated;
      _currentUser = null;
    } else {
      await _loadUserData(firebaseUser);
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> _loadUserData(User firebaseUser) async {
    try {
      final existingUser = await _dbService.getUser(firebaseUser.uid);
      if (existingUser != null) {
        // Returning user – update last login
        await _dbService.updateUser(firebaseUser.uid, {
          'lastLogin': Timestamp.fromDate(DateTime.now()),
        });
        _currentUser = existingUser.copyWith(lastLogin: DateTime.now());
      } else {
        // First-time user – save Google profile data to Firestore
        _currentUser = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
          photoURL: firebaseUser.photoURL,
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );
        await _dbService.createUser(_currentUser!);
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();

      final firebaseUser = await _authService.signInWithGoogle();
      if (firebaseUser == null) {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
      // authStateChanges listener handles the rest
      return true;
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateUserAge(int age) async {
    if (_currentUser == null) return;
    try {
      await _dbService.updateUser(_currentUser!.uid, {'age': age});
      _currentUser = _currentUser!.copyWith(age: age);
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating age: $e');
    }
  }

  Future<void> updatePoints(int points) async {
    if (_currentUser == null) return;
    try {
      final newTotal = _currentUser!.totalPoints + points;
      await _dbService.updateUser(_currentUser!.uid, {'totalPoints': newTotal});
      _currentUser = _currentUser!.copyWith(totalPoints: newTotal);
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating points: $e');
    }
  }

  Future<void> updateStreak() async {
    if (_currentUser == null) return;
    try {
      final newStreak = _currentUser!.currentStreak + 1;
      final longestStreak = newStreak > _currentUser!.longestStreak
          ? newStreak
          : _currentUser!.longestStreak;
      await _dbService.updateUser(_currentUser!.uid, {
        'currentStreak': newStreak,
        'longestStreak': longestStreak,
      });
      _currentUser = _currentUser!.copyWith(
        currentStreak: newStreak,
        longestStreak: longestStreak,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating streak: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      _currentUser = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  Future<void> deleteAccount() async {
    if (_currentUser == null) return;
    try {
      await _dbService.deleteUser(_currentUser!.uid);
      await _authService.deleteAccount();
      _currentUser = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting account: $e');
    }
  }
}
