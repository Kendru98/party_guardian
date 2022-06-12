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
        color: Color(0xff7046e0),
        child: Column(
          children: [
            //wstaw wykres
            SfCartesianChart(
              annotations: <CartesianChartAnnotation>[
                CartesianChartAnnotation(
                    x: MediaQuery.of(context).size.width / 1.5,
                    y: 52,
                    widget: Column(
                      children: <Widget>[
                        Row(children: [
                          const Icon(FontAwesomeIcons.minus,
                              color: Colors.red, size: 24),
                          Text('Spożywanie',
                              style: Theme.of(context).textTheme.headline1),
                        ]),
                        Row(children: [
                          const Icon(FontAwesomeIcons.minus,
                              color: Colors.green, size: 24),
                          Text('Trzeźwienie',
                              style: Theme.of(context).textTheme.headline1)
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
                textStyle: Theme.of(context).textTheme.headline1,
                text: 'Współczynnik BAC: '
                    '${calculateBAC(widget.calcdata).toStringAsFixed(3)} %',
              ),
              // legend: Legend(
              //     isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              primaryXAxis: CategoryAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 2,
                labelStyle: Theme.of(context).textTheme.headline1,
              ),
              primaryYAxis: NumericAxis(
                  labelStyle: Theme.of(context).textTheme.headline1,
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
                  width: 3,

                  // isVisibleInLegend: true,
                  // legendItemText: 'Legenda',
                ),
              ],
            ),
            Text('Zacząłeś spożywać alkohol o ${widget.calcdata.startTime}\n'),
            Text('Skończyłeś spożywać alkohol o ${widget.calcdata.endTime}\n'),
            Text('Wytrzeźwiejesz o ${widget.chartdata.last.hour}\n'),
          ],
        ),
      ),
    );
  }
}
