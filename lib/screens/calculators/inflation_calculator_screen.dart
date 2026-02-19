import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:finlit/providers/calculator_provider.dart';
import 'package:finlit/constants/app_constants.dart';

class InflationCalculatorScreen extends StatefulWidget {
  const InflationCalculatorScreen({super.key});

  @override
  State<InflationCalculatorScreen> createState() =>
      _InflationCalculatorScreenState();
}

class _InflationCalculatorScreenState extends State<InflationCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _currentPriceController = TextEditingController();
  final _yearsController = TextEditingController();
  final _inflationRateController = TextEditingController(text: '6.0');
  Map<String, dynamic>? _result;

  @override
  void dispose() {
    _itemNameController.dispose();
    _currentPriceController.dispose();
    _yearsController.dispose();
    _inflationRateController.dispose();
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
      appBar: AppBar(title: const Text('Inflation Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inflation Impact',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'See how inflation changes the future price of things.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Item name
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  hintText: 'e.g., Cup of Coffee',
                  prefixIcon: Icon(Icons.shopping_bag_outlined),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter an item name' : null,
              ),
              const SizedBox(height: 16),

              // Current price
              TextFormField(
                controller: _currentPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Current Price (₹)',
                  hintText: 'e.g., 200',
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter current price';
                  if (double.tryParse(v) == null || double.parse(v) <= 0)
                    return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Years
              TextFormField(
                controller: _yearsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Years',
                  hintText: 'e.g., 10',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter number of years';
                  final years = int.tryParse(v);
                  if (years == null || years < 1 || years > 50)
                    return 'Enter 1-50 years';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Inflation rate
              TextFormField(
                controller: _inflationRateController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Inflation Rate (% per year)',
                  hintText: 'Default: 6%',
                  prefixIcon: Icon(Icons.percent),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter inflation rate';
                  if (double.tryParse(v) == null) return 'Enter a valid rate';
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

                // Price comparison card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          _itemNameController.text,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Today',
                                    style: TextStyle(
                                      color: AppConstants.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currencyFormat.format(
                                      _result!['currentPrice'],
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: AppConstants.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: AppConstants.textSecondary,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'In ${_result!['years']} years',
                                    style: const TextStyle(
                                      color: AppConstants.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currencyFormat.format(
                                      _result!['futurePrice'],
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: AppConstants.accentRed,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 32),
                        _buildResultRow(
                          context,
                          'Price Increase',
                          currencyFormat.format(_result!['priceIncrease']),
                          Icons.arrow_upward,
                        ),
                        _buildResultRow(
                          context,
                          'Percentage Increase',
                          '${(_result!['percentageIncrease'] as double).toStringAsFixed(1)}%',
                          Icons.percent,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Educational note
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppConstants.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: AppConstants.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Why this matters',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: AppConstants.primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is why investing matters! Your money needs to grow faster than '
                        'inflation, otherwise your purchasing power decreases over time. '
                        'Simply keeping money in a jar means it loses value every year.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // Formula explanation
              ExpansionTile(
                title: const Text('How is this calculated?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Future Value = Current Price × (1 + Inflation Rate / 100) ^ Years\n\n'
                      'For example, if coffee costs ₹200 today with 6% inflation:\n'
                      'In 10 years: 200 × (1.06)^10 = ₹358\n'
                      'In 20 years: 200 × (1.06)^20 = ₹641',
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppConstants.accentRed),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppConstants.accentRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final calculator = context.read<CalculatorProvider>();
    final result = calculator.calculateInflation(
      currentPrice: double.parse(_currentPriceController.text),
      years: int.parse(_yearsController.text),
      inflationRate: double.parse(_inflationRateController.text),
    );

    setState(() => _result = result);
  }
}
