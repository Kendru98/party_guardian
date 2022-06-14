import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:party_guardian/models/alcohol_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResultPage extends StatefulWidget {
  final List<ChartData> chartdata;
  final CalculationData calcdata;
  const ResultPage(
      {super.key, required this.chartdata, required this.calcdata});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final whensober =
        widget.chartdata.last.hour.difference(DateTime.now()).inMinutes;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        //jezyk daty, i jezyk apki na PL
        child: Container(
          color: Color(0xff7046e0),
          child: Column(
            children: [
              //wstaw wykres
              SfCartesianChart(
                trackballBehavior: TrackballBehavior(
                    enable: true,
                    tooltipSettings: const InteractiveTooltip(
                        enable: true, color: Colors.black)),
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
                'Zacząłeś spożywać alkohol w ${DateFormat.E('pl').add_Hm().format(widget.calcdata.startTime)}.\n',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'Skończyłeś spożywać alkohol w ${DateFormat.E('pl').add_Hm().format(widget.calcdata.endTime)}\n',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                  'Wytrzeźwiejesz:  ${DateFormat.E('pl').add_Hm().format(widget.chartdata.last.hour)},${sobertext(whensober, widget.calcdata.endTime, widget.chartdata.last.hour)}',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Text(
                    '*Wartości wyliczone w aplikacji mają jedynie charakter szacunkowy i nie powinny być przyjmowane jako rzeczywisty poziom stężenia alkoholu we krwi. Uzyskanie wyniku 0 nie oznacza trzeźwości.' +
                        ' Aby uzyskać realne wyniki należy skorzystać z certyfkowanego alkomatu lub udać się na badanie w najbliższym komisariacie policji.',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String sobertext(int difference, DateTime drinkend, DateTime sobertime) {
  if (difference > 0 && sobertime.isAfter(DateTime.now())) {
    return ' czyli za ${(difference / 60).ceil().toString().padLeft(2, "0")}:${(difference % 60)} h';
  } else {
    return ' czyli jesteś już trzeźwy!';
  }
}
