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
            //wstaw wykres
            SfCartesianChart(
              annotations: <CartesianChartAnnotation>[
                CartesianChartAnnotation(
                    x: MediaQuery.of(context).size.width / 1.5,
                    y: 40,
                    horizontalAlignment: ChartAlignment.near,
                    verticalAlignment: ChartAlignment.center,
                    widget: Column(
                      children: <Widget>[
                        Row(children: const [
                          Icon(Icons.circle, color: Colors.red, size: 16),
                          Text('Spożywanie', style: TextStyle()),
                        ]),
                        Row(children: const [
                          Icon(Icons.circle, color: Colors.green, size: 16),
                          Text('Trzeźwienie', style: TextStyle())
                        ]),
                      ],
                    ))
              ],
              // coordinateUnit: CoordinateUnit.percentage,
              // x: kIsWeb ? '95%' : '85%',
              // y: kIsWeb
              //     ? '19%'
              //     : orientation == Orientation.portrait
              //         ? '14%'
              //         : '17%')

              title: ChartTitle(
                text: 'Współczynnik BAC: '
                    '${calculateBAC(widget.calcdata).toStringAsFixed(3)} %',
              ),
              // legend: Legend(
              //     isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              primaryXAxis: CategoryAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 2,
                  title: AxisTitle(text: 'Czas')),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value} ‰',
                  axisLine: const AxisLine(width: 0),
                  majorTickLines:
                      const MajorTickLines(color: Colors.transparent)),

              series: <LineSeries<ChartData, String>>[
                LineSeries<ChartData, String>(
                  dataSource: widget.chartdata,
                  xValueMapper: (ChartData chart, _) => chart.hour,
                  yValueMapper: (ChartData chart, _) => chart.bac,
                  pointColorMapper: (ChartData chart, _) => chart.lineColor,
                  dataLabelMapper: (ChartData chart, _) => chart.labeltext,
                  width: 2,

                  // isVisibleInLegend: true,
                  // legendItemText: 'Legenda',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
