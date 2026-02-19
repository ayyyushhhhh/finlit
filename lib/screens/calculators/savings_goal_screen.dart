import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:finlit/providers/auth_provider.dart';
import 'package:finlit/providers/calculator_provider.dart';
import 'package:finlit/models/savings_goal_model.dart';
import 'package:finlit/constants/app_constants.dart';

class SavingsGoalScreen extends StatefulWidget {
  const SavingsGoalScreen({super.key});

  @override
  State<SavingsGoalScreen> createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends State<SavingsGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _goalNameController = TextEditingController();
  final _targetController = TextEditingController();
  final _monthlyController = TextEditingController();
  final _interestController = TextEditingController(text: '6.0');
  SavingsGoalModel? _result;

  @override
  void dispose() {
    _goalNameController.dispose();
    _targetController.dispose();
    _monthlyController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Savings Goal Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set Your Savings Goal',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Find out how long it takes to reach your financial goal.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Goal name
              TextFormField(
                controller: _goalNameController,
                decoration: const InputDecoration(
                  labelText: 'Goal Name',
                  hintText: 'e.g., New Laptop',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter a goal name' : null,
              ),
              const SizedBox(height: 16),

              // Target amount
              TextFormField(
                controller: _targetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Target Amount (₹)',
                  hintText: 'e.g., 50000',
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter target amount';
                  if (double.tryParse(v) == null || double.parse(v) <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Monthly saving
              TextFormField(
                controller: _monthlyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Monthly Saving (₹)',
                  hintText: 'e.g., 5000',
                  prefixIcon: Icon(Icons.savings_outlined),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter monthly saving';
                  if (double.tryParse(v) == null || double.parse(v) <= 0)
                    return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Interest rate
              TextFormField(
                controller: _interestController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Interest Rate (% per year)',
                  hintText: 'e.g., 6.0',
                  prefixIcon: Icon(Icons.percent),
                ),
                validator: (v) {
                  if (v != null && v.isNotEmpty) {
                    if (double.tryParse(v) == null) return 'Enter a valid rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Calculate button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _calculate,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate'),
                ),
              ),

              // Results
              if (_result != null) ...[
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Results for "${_result!.goalName}"',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Divider(height: 24),
                        _buildResultRow(
                          context,
                          'Time Required',
                          _formatMonths(_result!.monthsRequired),
                          Icons.timer,
                        ),
                        _buildResultRow(
                          context,
                          'Total Saved',
                          currencyFormat.format(
                            _result!.monthlySaving * _result!.monthsRequired,
                          ),
                          Icons.account_balance,
                        ),
                        _buildResultRow(
                          context,
                          'Total with Interest',
                          currencyFormat.format(_result!.totalWithInterest),
                          Icons.trending_up,
                        ),
                        _buildResultRow(
                          context,
                          'Interest Earned',
                          currencyFormat.format(
                            _result!.totalWithInterest -
                                (_result!.monthlySaving *
                                    _result!.monthsRequired),
                          ),
                          Icons.currency_rupee,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _saveGoal,
                    icon: const Icon(Icons.save),
                    label: const Text('Save This Goal'),
                  ),
                ),
              ],
              const SizedBox(height: 24),

              // Formula explanation
              ExpansionTile(
                title: const Text('How is this calculated?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'With compound interest, your savings grow each month:\n\n'
                      'Each month: Balance = Previous Balance × (1 + monthly rate) + Monthly Saving\n\n'
                      'Monthly rate = Annual Rate / 12 / 100\n\n'
                      'The calculator finds how many months until your balance reaches the target.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppConstants.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatMonths(int months) {
    final years = months ~/ 12;
    final remainingMonths = months % 12;
    if (years == 0) return '$remainingMonths months';
    if (remainingMonths == 0) return '$years years';
    return '$years years, $remainingMonths months';
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final calculator = context.read<CalculatorProvider>();

    final result = calculator.calculateSavingsGoal(
      userId: auth.currentUser?.uid ?? '',
      goalName: _goalNameController.text,
      targetAmount: double.parse(_targetController.text),
      monthlySaving: double.parse(_monthlyController.text),
      interestRate:
          double.tryParse(_interestController.text) ??
          AppConstants.defaultInterestRate,
    );

    setState(() => _result = result);
  }

  Future<void> _saveGoal() async {
    if (_result == null) return;
    final calculator = context.read<CalculatorProvider>();
    await calculator.saveSavingsGoal(_result!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Goal saved successfully!'),
          backgroundColor: AppConstants.secondaryColor,
        ),
      );
    }
  }
}
