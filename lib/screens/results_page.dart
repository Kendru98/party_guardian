import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:party_guardian/models/alcohol_model.dart';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

class ResultPage extends StatefulWidget {
  final List<ChartData> chartdata;
  final CalculationData calcdata;
  ResultPage({required this.chartdata, required this.calcdata});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  @override
  Widget build(BuildContext context) {
    // final whensober = widget.chartdata.last.hour - DateTime.now();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Color(0xff7046e0),
        child: Column(
          children: [
            //wstaw wykres
            SfCartesianChart(
              trackballBehavior: TrackballBehavior(
                  enable: true,
                  tooltipSettings:
                      InteractiveTooltip(enable: true, color: Colors.black)),
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

              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.Hm('pl').add_E(),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                majorGridLines: const MajorGridLines(width: 0),
                interval: 1,
                labelStyle: Theme.of(context).textTheme.headline1,
                interactiveTooltip: InteractiveTooltip(enable: true),
              ),
              crosshairBehavior: CrosshairBehavior(
                  enable: true, activationMode: ActivationMode.singleTap),
              primaryYAxis: NumericAxis(
                  labelStyle: Theme.of(context).textTheme.headline1,
                  labelFormat: '{value} ‰',
                  axisLine: const AxisLine(width: 0),
                  majorTickLines:
                      const MajorTickLines(color: Colors.transparent)),

              series: <LineSeries<ChartData, DateTime>>[
                LineSeries<ChartData, DateTime>(
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
            Text(
                'Zacząłeś spożywać alkohol  ${DateFormat("yyyy-MM-dd HH:mm:ss").format(widget.calcdata.startTime)}.\n'),
            Text(
                'Skończyłeś spożywać alkohol  ${DateFormat("yyyy-MM-dd HH:mm:ss").format(widget.calcdata.endTime)}\n'),
            Text(
                'Wytrzeźwiejesz za ${DateFormat("yyyy-MM-dd HH:mm:ss").format(widget.chartdata.last.hour)}\n'),
          ],
        ),
      ),
    );
  }
}
