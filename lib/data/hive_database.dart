import 'package:hive_flutter/adapters.dart';
import 'package:trackify/models/expense_item.dart';

class HiveDataBase{
  // reference our box
  final _mybox = Hive.box("trackify_database");

  // write data
  void savedata(List<ExpenseItem> allExpense){
    // hive stores primitive datatypes

    List<dynamic> allExpenseFormatted = [];
    for(var expense in allExpense){
      //converting expenseItem list into primitive datatypes
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


  //read data
  List savedExpenses = _mybox.get("ALL_EXPENSES")?? [];
  List<ExpenseItem> allExpenses = [];



}