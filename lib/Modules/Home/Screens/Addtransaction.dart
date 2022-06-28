import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zavvy/Core/DBhelper.dart';
import 'package:zavvy/Model/Transaction/Expense.dart';
import 'package:zavvy/Modules/Home/Controller/AddTransactionController.dart';
import 'package:zavvy/Modules/Home/Screens/Homepage.dart';

class AddTransaction extends StatefulWidget {
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  //const AddTransaction({Key? key}) : super(key: key);
  AddtransactionController addTransactionController =
      Get.put(AddtransactionController());

  DateTime dt = DateTime.now();
  DateTime month = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                text("Category"),
                Obx(() => DropdownButton(
                      hint: Text(
                        'Category',
                      ),
                      onChanged: (newValue) {
                        addTransactionController
                            .setSelected(newValue.toString());
                      },
                      value: addTransactionController.selected.value,
                      items:
                          addTransactionController.listType.map((selectedType) {
                        return DropdownMenuItem(
                          child: new Text(
                            selectedType,
                          ),
                          value: selectedType,
                        );
                      }).toList(),
                    )),
                text("Amount"),
                TextField(
                  controller: addTransactionController.amountController,
                  keyboardType: TextInputType.number,
                ),
                text("Description"),
                TextField(
                  controller: addTransactionController.descController,
                ),
                text("Date"),
                TextField(
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: addTransactionController.dateController,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                TextButton(
                    onPressed: () => addTransaction().whenComplete(() {
                          DBhelper db = new DBhelper();
                          db.refresh();
                          Get.to(Homepage());
                        }),
                    child: Text("ADD"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    var data = Expense(
      id: DateTime.fromMillisecondsSinceEpoch(1633247247 * 1000).toString(),
      category: addTransactionController.selected.toString(),
      desc: addTransactionController.descController.text,
      amount: int.parse(addTransactionController.amountController.text),
      date: dt,
    );
    DBhelper.addData(data);
  }

  Widget text(String data) {
    return Text(
      data,
      style: TextStyle(fontSize: 18),
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
        dt = selected;
      }

      addTransactionController.dateController.text =
          DateTime(selected.year, selected.month, selected.day)
              .toString()
              .substring(0, 10);
      // addTransactionController.dateTime.value =
      //     DateTime(selected.year, selected.month, selected.day);
      // addTransactionController.dateController.text =
      //     DateTime(selected.year, selected.month, selected.day)
      //         .toString()
      //.substring(0, 10);
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
