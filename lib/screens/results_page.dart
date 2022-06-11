import 'package:flutter/material.dart';
import 'package:party_guardian/models/alcohol_model.dart';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResultPage extends StatefulWidget {
  final List<ChartData> chartdata;
  final CalculationData calcdata;
  ResultPage({required this.chartdata, required this.calcdata});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Text(
              'Bac: ' '${calculateBAC(widget.calcdata)}',
              style: TextStyle(fontSize: 20),
            ),

            //wstaw wykres
            SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                series: <ChartSeries>[
                  // Renders line chart

                  LineSeries<ChartData, DateTime>(
                      dataSource: widget.chartdata,
                      xValueMapper: (ChartData chart, _) => chart.hour,
                      yValueMapper: (ChartData chart, _) => chart.promile)
                ])
          ],
        ),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   final List<SalesData> chartData = [
//     SalesData(2010, 35),
//     SalesData(2011, 28),
//     SalesData(2012, 34),
//     SalesData(2013, 32),
//     SalesData(2014, 40)
//   ];

//   return Scaffold(
//       body: Center(
//           child: Container(
//               child: SfCartesianChart(
//                   primaryXAxis: DateTimeAxis(),
//                   series: <ChartSeries>[
//         // Renders line chart
//         LineSeries<SalesData, DateTime>(
//             dataSource: chartData,
//             xValueMapper: (SalesData sales, _) => sales.year,
//             yValueMapper: (SalesData sales, _) => sales.sales)
//       ]))));
// }

// class SalesData {
//   SalesData(this.year, this.sales);
//   final DateTime year;
//   final double sales;
// }
