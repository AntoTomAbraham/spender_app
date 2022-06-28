import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zavvy/Model/Transaction/Expense.dart';

class DBhelper {
  ValueNotifier<List<Expense>> expenseList = ValueNotifier([]);
  static List<Expense> expense = [];
  static Future<void> addData(Expense obj) async {
    final db = await Hive.openBox<Expense>('expenses');
    await db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final list = await getallExpenses();
    list.sort(
      (a, b) => b.date.compareTo(a.date),
    );
    expense = list;
    expenseList.value.clear();
    expenseList.value.addAll(list);
    expenseList.notifyListeners();
    print(expenseList);
  }

  Future<void> orderBymonth(DateTime year) async {
    final list = await getallExpenses();
    list.sort(
      (a, b) => b.date.compareTo(a.date),
    );
    list.where((element) => element.date.month == year.month).toList();
    expense = list;
    expenseList.value.clear();
    expenseList.value.addAll(list);
    expenseList.notifyListeners();
    print(expenseList);
  }

  static Future<List<Expense>> getallExpenses() async {
    final db = await Hive.openBox<Expense>('expenses');
    return db.values.toList();
  }
}
