import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  log('${bac}BAC start ${gramsofalcohol}grams of alcohol');
  // bac = bac - (calculationData.estimatedtime * 0.015);
  // log('${bac}BAC  ${gramsofalcohol}grams of alcohol');

  return bac; // * 10 => bac // bac w momencie konca picia
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

chartdata(DateTime from, DateTime until, double bac) {
  List<ChartData> chartData = [];
  Duration period = const Duration(hours: 1);
  var current = from;

  while (bac > 0.00) {
    if (current.isBefore(until)) {
      chartData.add(ChartData('${DateFormat('HH:mm').format(current)}h',
          bac * 10, Colors.red, 'Czas spożywania'));
    } else {
      chartData.add(ChartData('${DateFormat('HH').format(current)}h', bac * 10,
          Colors.green, 'Czas trzeźwienia'));
    }

    bac = bac - (1 * 0.015);
    print(current);
    print(bac);
    current = current.add(period);
  }
  return chartData;
}

class ChartData {
  ChartData(this.hour, this.bac, this.lineColor, this.labeltext);
  final String hour;
  final double bac;
  final Color? lineColor;
  final String labeltext;
}
