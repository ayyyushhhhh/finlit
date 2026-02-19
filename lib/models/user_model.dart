import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final int? age;
  final String? photoURL;
  final DateTime createdAt;
  final DateTime lastLogin;
  final int totalPoints;
  final int currentStreak;
  final int longestStreak;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.age,
    this.photoURL,
    required this.createdAt,
    required this.lastLogin,
    this.totalPoints = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'age': age,
      'photoURL': photoURL,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
      'totalPoints': totalPoints,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      age: map['age'],
      photoURL: map['photoURL'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLogin: (map['lastLogin'] as Timestamp?)?.toDate() ?? DateTime.now(),
      totalPoints: map['totalPoints'] ?? 0,
      currentStreak: map['currentStreak'] ?? 0,
      longestStreak: map['longestStreak'] ?? 0,
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    int? age,
    String? photoURL,
    DateTime? createdAt,
    DateTime? lastLogin,
    int? totalPoints,
    int? currentStreak,
    int? longestStreak,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      totalPoints: totalPoints ?? this.totalPoints,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
    );
  }
}
