import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackify/bar_graph/bar_graph.dart';
import 'package:trackify/data/expense_data.dart';
import 'package:trackify/date_time/date_time_helper.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of the week
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context, value, child) =>  const SizedBox(
          height: 200,
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
