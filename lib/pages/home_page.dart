import 'package:flutter/material.dart';

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
    
  }
  
  void cancelExpense(){
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
              child: const Icon(
                  Icons.add,
              ),
      ),
    );
  }
}
