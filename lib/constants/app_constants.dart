import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'FinLit';
  static const String tagline = 'Master Your Money, Secure Your Future';

  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color accentRed = Color(0xFFFF6B6B);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);

  // Category Colors
  static const Color budgetingColor = Color(0xFFFF9800);
  static const Color savingColor = Color(0xFF4CAF50);
  static const Color investingColor = Color(0xFF2196F3);
  static const Color creditColor = Color(0xFF9C27B0);

  // Budget Simulator defaults
  static const double defaultIncome = 50000;
  static const double defaultRent = 15000;
  static const double defaultFood = 8000;
  static const double defaultTransport = 3000;
  static const double defaultEntertainment = 5000;
  static const double defaultSavings = 10000;

  // Points
  static const int pointsPerCorrectAnswer = 10;
  static const int pointsPerLessonComplete = 20;

  // Default inflation rate
  static const double defaultInflationRate = 6.0;
  static const double defaultInterestRate = 6.0;
}
