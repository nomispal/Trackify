import 'package:flutter/material.dart';
import 'package:trackify/date_time/date_time_helper.dart';
import 'package:trackify/models/expense_item.dart';

class ExpenseData extends ChangeNotifier{

  // list of all expenses
  List<ExpenseItem> allExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseData(){
    return allExpenseList;

    notifyListeners();
  }

  // add new Expense
  void addNewExpense(ExpenseItem newExpense){
    allExpenseList.add(newExpense);

    notifyListeners();

  }

  // delete Expense
  void deleteExpense(ExpenseItem expense){
    allExpenseList.remove(expense);

    notifyListeners();

  }

  //get weekday (mon, sat, sun) from a datetime object
  String getDayName(DateTime dateTime){
    switch(dateTime.weekday){
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return "Friday";
      case 6:
        return 'Sat';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  //get the date for the start of week (sunday)
  DateTime startOfWeekDate(){
    DateTime? startOfWeek;

    // get todays day
    DateTime today = DateTime.now();

    // go backwards to find sunday
    for(int i=0; i<7;i++){
      if(getDayName(today.subtract(Duration(days: i)))== 'Sunday'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek! ;
  }

  // convert all expenses to into a daily summary
  Map<String,double> calculateDailyExpenseSummary(){
    Map<String,double> dailyExpenseSummary={
    };
    for(var expense in allExpenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += currentAmount;
        dailyExpenseSummary[date] = currentAmount;
      }else{
       dailyExpenseSummary.addAll({date:amount});
      }
    }
    return dailyExpenseSummary;
  }
}