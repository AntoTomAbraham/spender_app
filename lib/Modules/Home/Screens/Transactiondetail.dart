import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transactiondetail extends StatelessWidget {
  //const Transactiondetail({Key? key}) : super(key: key);
  String category;
  String desc;
  String date;
  String amount;
  Transactiondetail(
      {required this.category,
      required this.amount,
      required this.date,
      required this.desc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Category: $category'),
            Text('Description: $desc'),
            Text('Date: $date'),
            Text('RS $amount'),
          ],
        ),
      ),
    );
  }
}
