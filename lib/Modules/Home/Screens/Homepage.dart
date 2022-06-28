import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zavvy/Core/DBhelper.dart';
import 'package:zavvy/Model/Transaction/Expense.dart';
import 'package:zavvy/Modules/Analytics/Screens/Analytics.dart';
import 'package:zavvy/Modules/Home/Screens/Addtransaction.dart';
import 'package:zavvy/Modules/Home/Screens/Transactiondetail.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //const Homepage({Key? key}) : super(key: key);
  DBhelper db = new DBhelper();
  DateTime month = DateTime.now();
  int year = 2022;
  List<FlSpot> dataset = [];

  @override
  Widget build(BuildContext context) {
    db.refresh();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(AddTransaction());
        },
        label: Text("Add new Transaction"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Container(
        height: Get.height * 1,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 20),
                GestureDetector(
                    onTap: () {
                      Get.to(Analytics(
                        datasett: dataset.toSet().toList(),
                      ));
                    },
                    child: Text("View Analytics")),
                SizedBox(width: 25),
                // Text("Sort By:"),
                // SizedBox(width: 20),
                // GestureDetector(
                //     onTap: () {},
                //     child: DropdownButton<String>(
                //       hint: Text("Year"),
                //       items: <String>['2022', '2021', '2020', '2019']
                //           .map((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //       onChanged: (val) {
                //         setState(() {
                //           year = int.parse(val!);
                //         });
                //       },
                //     )),
                // SizedBox(width: 10),
                // GestureDetector(
                //     onTap: () {
                //       _selectDate(context);
                //       DBhelper().orderBymonth(month);
                //       db.refresh();
                //     },
                //     child: Text("Select month")),
                SizedBox(width: 20),
              ],
            ),
            Container(
              height: Get.height * .9,
              child: ValueListenableBuilder(
                  valueListenable: db.expenseList,
                  builder:
                      (BuildContext ctx, List<Expense> expenseList, Widget? _) {
                    return ListView.separated(
                        itemBuilder: (ctx, index) {
                          final value = expenseList[index];
                          //if (value.date.month == DateTime.now().month) {
                          dataset.add(FlSpot(value.date.month.toDouble(),
                              value.amount.toDouble()));
                          //}
                          //print(dataset);
                          return expenseWidget(
                            value.amount.toString(),
                            value.category.toString(),
                            value.date.toString().substring(0, 10),
                            value.desc.toString(),
                          );
                        },
                        separatorBuilder: (ctx, length) {
                          return const SizedBox(height: 20);
                        },
                        itemCount: expenseList.length);
                  }),
            )
          ],
        )),
      ),
    );
  }

  Widget expenseWidget(
      String date, String amount, String category, String desc) {
    return GestureDetector(
      onTap: () {
        Get.to(Transactiondetail(
            category: category, amount: date, date: amount, desc: desc));
      },
      child: Card(
        child: ListTile(
          leading: Text('RS $date'),
          title: Text(amount),
          subtitle: Text(category),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    );
    if (selected != null) {
      setState() {
        month = selected;
      }

      // addTransactionController.dateController.text =
      //     DateTime(selected.year, selected.month, selected.day)
      //         .toString()
      //         .substring(0, 10);
      // addTransactionController.dateTime.value =
      //     DateTime(selected.year, selected.month, selected.day);
      // addTransactionController.dateController.text =
      //     DateTime(selected.year, selected.month, selected.day)
      //         .toString()
      //.substring(0, 10);
    }
  }
}
