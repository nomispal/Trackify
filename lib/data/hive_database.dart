import 'package:hive_flutter/adapters.dart';
import 'package:trackify/models/expense_item.dart';

class HiveDataBase {
  // reference our box
  final _mybox = Hive.box("trackify_database");

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    // hive stores primitive datatypes
    List<List<dynamic>> allExpenseFormatted = [];
    for (var expense in allExpense) {
      // converting expenseItem list into primitive datatypes
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    // saving into database
    _mybox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  // read data
  List<List<dynamic>> get savedExpenses => _mybox.get("ALL_EXPENSES") ?? [];

  List<ExpenseItem> getAllExpenses() {
    List<ExpenseItem> allExpenses = [];
    for (var expense in savedExpenses) {
      allExpenses.add(
        ExpenseItem(
          name: expense[0],
          amount: expense[1],
          dateTime: expense[2],
        ),
      );
    }
    return allExpenses;
  }
}
