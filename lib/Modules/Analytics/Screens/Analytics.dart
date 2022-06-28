import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/DBhelper.dart';

class Analytics extends StatefulWidget {
  List<FlSpot> datasett;
  Analytics({required this.datasett});
  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  //const Analytics({Key? key}) : super(key: key);
  DBhelper db = new DBhelper();

  List<FlSpot> dataset = [];

  List<FlSpot> getPlotPoints() {
    print("DBheoper ");
    print(DBhelper.expense);
    DBhelper.expense.map((e) {
      print("inside getPlotpoints");
      if (e.date.month == DateTime.now().month) {
        setState(() {
          dataset.add(FlSpot(e.date.month.toDouble(), e.amount.toDouble()));
        });
      }
    });
    print(dataset);
    return dataset;
  }

  @override
  void initState() {
    getPlotPoints();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height * 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  height: Get.height * .6,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                            spots: widget.datasett,
                            isCurved: false,
                            barWidth: 2.5,
                            colors: [
                              Colors.purple,
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
