import 'package:flutter/cupertino.dart';

class Alcohols {
  final String name;
  final double percent;
  final double volume;

  Alcohols({required this.name, required this.percent, required this.volume});

  static List<Alcohols> AlcoholsList = [
    Alcohols(name: 'beer', percent: 5, volume: 500),
    Alcohols(name: 'wine', percent: 13, volume: 175),
    Alcohols(name: 'champagne', percent: 11, volume: 120),
    Alcohols(name: 'vodka', percent: 40, volume: 50),
  ];
}
