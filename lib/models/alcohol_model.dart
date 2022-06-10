import 'dart:developer';

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

  CalculationData(
      this.gender, this.weight, this.estimatedtime, this.currentAlcohols);
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
  bac = bac - (calculationData.estimatedtime * 0.015);
  log(bac.toString() +
      'BAC  ' +
      gramsofalcohol.toString() +
      'grams of alcohol');
  return bac; // * 10 => promile
}

gramsofalcoholcount(List<Alcohols> alcohollist) {
  double allalcoholgrams = 0.00;
  alcohollist.asMap().forEach((index, value) {
    double gramsofalcohol =
        alcohollist[index].volume * (alcohollist[index].percent / 100) * 0.789;
    allalcoholgrams = allalcoholgrams + gramsofalcohol;
  });
  return allalcoholgrams;
}
