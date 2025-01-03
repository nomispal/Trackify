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

  // text controllers
  final expenseNameController = TextEditingController();
  final amountNameController = TextEditingController();


  // function for adding new expense
  void addNewExpense(){
    // add new expense
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
      title: const Text("Add new expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense Name
            TextField(
              controller: expenseNameController,
            ),

            // Expense Amount
            TextField(
              controller: amountNameController,
            ),
          ],
        ),
        actions: [
          // cancel button
          MaterialButton(
            onPressed: cancelExpense,
            child: Text("Cancel")
          ),

          // Save button
          MaterialButton(
            onPressed: saveExpense,
            child: Text("Save")
          )
        ],
      ),
    );

  }

  
  // function for saving expense
  void saveExpense(){
    // create expense item
    ExpenseItem newExpenseItem = ExpenseItem(
        name: expenseNameController.text,
        amount: amountNameController.text,
        dateTime: DateTime.now()
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpenseItem);

    Navigator.pop(context);
    clearControllers();
  }
  
  void cancelExpense(){


    Navigator.pop(context);
    clearControllers();
  }


  void clearControllers(){
    expenseNameController.clear();
    amountNameController.clear();
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
          body:
            ListView(
             children: [
               const SizedBox(height: 10),

               //Weekly Summary
               ExpenseSummary(startOfWeek: value.startOfWeekDate()),

               const SizedBox(height: 20),

               // all expense
               ListView.builder(
                 shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: value.getAllExpenseData().length,
                   itemBuilder: (context, index) =>ExpenseTile(
                       amount: value.getAllExpenseData()[index].amount,
                       dateTime: value.getAllExpenseData()[index].dateTime,
                       name: value.getAllExpenseData()[index].name
                   )
               ),
             ],
            )
        )
    );
  }
}
