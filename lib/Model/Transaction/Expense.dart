import 'package:hive/hive.dart';
part 'Expense.g.dart';

@HiveType(typeId: 1)
class Expense {
  @HiveField(0)
  String id;
  @HiveField(1)
  String category;
  @HiveField(2)
  String desc;
  @HiveField(3)
  int amount;
  @HiveField(4)
  DateTime date;
  Expense({
    required this.id,
    required this.category,
    required this.desc,
    required this.amount,
    required this.date,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
