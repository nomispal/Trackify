import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackify/components/expense_summary.dart';
import 'package:trackify/components/expense_tile.dart';
import 'package:trackify/data/expense_data.dart';
import 'package:trackify/models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text controllers
  final expenseNameController = TextEditingController();
  final dollarController = TextEditingController();
  final centController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).getAllExpenseData();
  }

  // Function for adding new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[200],
        title: const Text("Add new expense",),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expense Name
              TextField(
                controller: expenseNameController,
                decoration: const InputDecoration(
                  labelText: "Expense Name",
                ),
              ),
              const SizedBox(height: 10),

              // Dollar and Cents Amount
              Row(
                children: [
                  // Dollar Field
                  Expanded(
                    child: TextField(
                      controller: dollarController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Dollars",
                        prefixText: "\$",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Space between fields

                  // Cents Field
                  Expanded(
                    child: TextField(
                      controller: centController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Cents",
                        prefixText: "¢",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          // Cancel button
          TextButton(
            onPressed: cancelExpense,
            child: const Text("Cancel",style: TextStyle(color: Colors.grey),),
          ),

          // Save button
          TextButton(
            onPressed: saveExpense,
            child: const Text("Save",style: TextStyle(color: Colors.grey),),
          ),
        ],
      ),
    );
  }

  // Function for saving expense
  void saveExpense() {
    if (expenseNameController.text.isNotEmpty &&
        dollarController.text.isNotEmpty &&
        centController.text.isNotEmpty) {
      // Combine dollars and cents into a single amount
      final dollars = int.tryParse(dollarController.text) ?? 0;
      final cents = int.tryParse(centController.text) ?? 0;
      final totalAmount = dollars + (cents / 100);

      // Create expense item
      ExpenseItem newExpenseItem = ExpenseItem(
        name: expenseNameController.text,
        amount: totalAmount.toStringAsFixed(2), // Format as a string with 2 decimals
        dateTime: DateTime.now(),
      );

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpenseItem);

      Navigator.pop(context); // Close the dialog
      clearControllers();
    }
  }

  void cancelExpense() {
    Navigator.pop(context); // Close the dialog
    clearControllers();
  }

  void clearControllers() {
    expenseNameController.clear();
    dollarController.clear();
    centController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: addNewExpense,
          backgroundColor: Colors.brown[300],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),

            // Weekly Summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            const SizedBox(height: 20),

            // All expenses
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseData().length,
              itemBuilder: (context, index) => ExpenseTile(
                amount: value.getAllExpenseData()[index].amount,
                dateTime: value.getAllExpenseData()[index].dateTime,
                name: value.getAllExpenseData()[index].name,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
