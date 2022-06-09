import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Alcohols {
  final String name;
  final double percent;
  final double volume;

  Alcohols({required this.name, required this.percent, required this.volume});

  //  List AlcoholsList = [
  //   Alcohols(name: 'beer', percent: 5, volume: 500),
  //   Alcohols(name: 'wine', percent: 13, volume: 175),
  //   Alcohols(name: 'champagne', percent: 11, volume: 120),
  //   Alcohols(name: 'vodka', percent: 40, volume: 50),
  // ];
  // getAlcohols() {
  //   final AlcoholsList = [Alcohols];
  // }
}

class AlcoholsDrop {
  final String name;
  final Icon icon;
  AlcoholsDrop(this.name, this.icon);

  List ListDrop = [
    AlcoholsDrop('Beer', Icon(FontAwesomeIcons.beerMugEmpty)),
    AlcoholsDrop('Wine', Icon(FontAwesomeIcons.wineGlass)),
    AlcoholsDrop('Champagne', Icon(FontAwesomeIcons.champagneGlasses)),
    AlcoholsDrop('Shot', Icon(FontAwesomeIcons.glassWater)),
  ];
}
