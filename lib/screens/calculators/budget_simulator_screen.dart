import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/budget_simulator_provider.dart';
import 'package:finlit/constants/app_constants.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetSimulatorScreen extends StatelessWidget {
  const BudgetSimulatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budget = context.watch<BudgetSimulatorProvider>();
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Simulator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => budget.resetAllocations(),
            tooltip: 'Reset',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Income display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryColor,
                    AppConstants.primaryColor.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Monthly Income',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currencyFormat.format(budget.fictionalIncome),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Allocations
            Text(
              'Divide Your Income',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            _buildSlider(
              context,
              budget,
              'rent',
              'Rent 🏠',
              30000,
              currencyFormat,
            ),
            _buildSlider(
              context,
              budget,
              'food',
              'Food 🍕',
              20000,
              currencyFormat,
            ),
            _buildSlider(
              context,
              budget,
              'transport',
              'Transport 🚌',
              10000,
              currencyFormat,
            ),
            _buildSlider(
              context,
              budget,
              'entertainment',
              'Entertainment 🎮',
              10000,
              currencyFormat,
            ),
            _buildSlider(
              context,
              budget,
              'savings',
              'Savings 💰',
              50000,
              currencyFormat,
            ),
            const SizedBox(height: 16),

            // Remaining balance
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: budget.isOverspent
                    ? AppConstants.accentRed.withOpacity(0.1)
                    : AppConstants.secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: budget.isOverspent
                      ? AppConstants.accentRed.withOpacity(0.3)
                      : AppConstants.secondaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remaining Balance',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    currencyFormat.format(budget.remainingBalance),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: budget.isOverspent
                          ? AppConstants.accentRed
                          : AppConstants.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Health Score
            _buildHealthScore(context, budget),
            const SizedBox(height: 16),

            // Pie Chart
            _buildPieChart(context, budget, currencyFormat),
            const SizedBox(height: 16),

            // Recommendation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.tips_and_updates, color: Colors.blue.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      budget.getRecommendation(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => _saveBudget(context),
                icon: const Icon(Icons.save),
                label: const Text('Save This Budget'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(
    BuildContext context,
    BudgetSimulatorProvider budget,
    String category,
    String label,
    double max,
    NumberFormat format,
  ) {
    final value = budget.allocations[category] ?? 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: Theme.of(context).textTheme.titleSmall),
              Text(
                format.format(value),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: 0,
            max: max,
            divisions: (max / 500).round(),
            activeColor: AppConstants.primaryColor,
            onChanged: (val) => budget.updateAllocation(category, val),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScore(
    BuildContext context,
    BudgetSimulatorProvider budget,
  ) {
    final score = budget.calculateHealthScore();
    final label = budget.getHealthLabel(score);
    final color = budget.getHealthColor(score);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                  Center(
                    child: Text(
                      '$score',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Financial Health Score',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(
    BuildContext context,
    BudgetSimulatorProvider budget,
    NumberFormat format,
  ) {
    final allocations = budget.allocations;
    final total = budget.totalAllocated;
    if (total <= 0) return const SizedBox.shrink();

    final colors = [
      AppConstants.accentRed,
      AppConstants.budgetingColor,
      AppConstants.investingColor,
      AppConstants.creditColor,
      AppConstants.secondaryColor,
    ];
    final labels = ['Rent', 'Food', 'Transport', 'Entertainment', 'Savings'];
    final keys = ['rent', 'food', 'transport', 'entertainment', 'savings'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget Breakdown',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: List.generate(keys.length, (i) {
                    final value = allocations[keys[i]] ?? 0;
                    final percentage = total > 0 ? (value / total * 100) : 0;
                    return PieChartSectionData(
                      value: value,
                      title: '${percentage.toStringAsFixed(0)}%',
                      color: colors[i],
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  }),
                  centerSpaceRadius: 30,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Legend
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: List.generate(labels.length, (i) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors[i],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      labels[i],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveBudget(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final budget = context.read<BudgetSimulatorProvider>();
    if (auth.currentUser != null) {
      await budget.saveBudgetSimulation(auth.currentUser!.uid);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Budget saved successfully!'),
            backgroundColor: AppConstants.secondaryColor,
          ),
        );
      }
    }
  }
}
