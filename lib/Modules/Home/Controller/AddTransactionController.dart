import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddtransactionController extends GetxController {
  //TODO: Implement AddtransactionController
  TextEditingController amountController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  final count = 0.obs;
  Rx<DateTime> dateTime = DateTime.now().obs;
  final selected = "Shopping".obs;
  List listType = [
    "Shopping",
    "Travelling",
    "Eating",
    "Medical",
    "Rent",
    "Movie",
    "Salary",
    "Transport",
    "Personal",
  ];
  void setSelected(String value) {
    selected.value = value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
