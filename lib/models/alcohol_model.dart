import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Alcohols {
  final String name;
  final double percent;
  final double volume;

  Alcohols({required this.name, required this.percent, required this.volume});
}

class CalculationData {
  final String gender;
  final String weight;
  final double estimatedtime;
  final List<Alcohols> currentAlcohols;
  final DateTime startTime;
  final DateTime endTime;

  CalculationData(this.gender, this.weight, this.estimatedtime,
      this.currentAlcohols, this.startTime, this.endTime);
}

calculateBAC(CalculationData calculationData) {
  double gendercost = 0;

  double gramsofalcohol = gramsofalcoholcount(calculationData.currentAlcohols);
  if (calculationData.gender == 'women') {
    gendercost = 0.55;
  } else if (calculationData.gender == 'men') {
    gendercost = 0.68;
  }
  var weightgrams = double.parse(calculationData.weight) * 1000;

  double bac = (gramsofalcohol / (weightgrams * gendercost)) * 100;
  // bacatime = bac - (calculationData.estimatedtime * 0.015);
  log('${bac}BAC  ${gramsofalcohol}grams of alcohol');

  return bac; // * 10 => promile
}

//bac per hour *0,015 per hour gives chart
gramsofalcoholcount(List<Alcohols> alcohollist) {
  double allalcoholgrams = 0.00;
  alcohollist.asMap().forEach((index, value) {
    double gramsofalcohol =
        alcohollist[index].volume * (alcohollist[index].percent / 100) * 0.789;
    allalcoholgrams = allalcoholgrams + gramsofalcohol;
  });
  return allalcoholgrams;
}

double hoursBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute);

  double hours = (to.difference(from).inMinutes) / 60;

  return hours;
}

chartdata(DateTime from, double bac) {
  double promile = bac * 10;
  DateTime end = DateTime.now();

  //double hours = (end.difference(from).inMinutes) / 60;
  List<ChartData> chartData = [];
  Duration period = Duration(minutes: 60);
  // for (var i = 0; i < hours; i++) {
  //   chartData.add(ChartData(, promile));
  //   promile = promile - (promile * 0.015);
  // }
  var current = from.add(period);
  log('${current}' '${end}');
  while (promile > 0.00) {
    chartData.add(ChartData(current, promile));
    promile = promile - (1 * 0.015);
    print(current);
    print(promile);
    current = current.add(period);
  }
  return chartData;
  //bac - (calculationData.estimatedtime * 0.015);
}

class ChartData {
  ChartData(this.hour, this.promile);
  final DateTime hour;
  final double promile;
}
