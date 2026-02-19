import 'package:flutter/material.dart';
import 'package:finlit/constants/app_constants.dart';
import 'package:finlit/screens/calculators/budget_simulator_screen.dart';
import 'package:finlit/screens/calculators/savings_goal_screen.dart';
import 'package:finlit/screens/calculators/inflation_calculator_screen.dart';

class CalculatorsScreen extends StatelessWidget {
  const CalculatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculators',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Practice with financial tools',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            _buildCalculatorCard(
              context,
              icon: Icons.account_balance_wallet,
              title: 'Budget Simulator',
              description:
                  'Practice dividing a monthly income into budget categories and see your financial health score.',
              color: AppConstants.budgetingColor,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BudgetSimulatorScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildCalculatorCard(
              context,
              icon: Icons.savings,
              title: 'Savings Goal Calculator',
              description:
                  'Find out how long it takes to reach your savings goal with monthly contributions.',
              color: AppConstants.savingColor,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavingsGoalScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _buildCalculatorCard(
              context,
              icon: Icons.trending_up,
              title: 'Inflation Calculator',
              description:
                  'See how inflation affects the future price of items and why investing matters.',
              color: AppConstants.investingColor,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InflationCalculatorScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppConstants.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: AppConstants.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
