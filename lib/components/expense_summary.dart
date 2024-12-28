import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackify/bar_graph/bar_graph.dart';
import 'package:trackify/data/expense_data.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => const SizedBox(
          height: 300,
          child: MyBarGraph(
              maxY: 100,
              monAmount: 20,
              tuesAmount: 30,
              wedAmount: 40,
              thusAmount: 50,
              friAmount: 32,
              satAmount: 4,
              sunAmount: 11,
          ),
        ),
    );
  }
}
