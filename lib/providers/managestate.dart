import 'package:flutter/material.dart';
import 'package:party_guardian/models/alcohol_model.dart';

class Manage extends ChangeNotifier {
  final List<Alcohols> _AlcoholList = [];

  List<Alcohols> get AlcoholList {
    return _AlcoholList;
  }

  void addList(Alcohols value) {
    _AlcoholList.add(value);

    notifyListeners();
  }

  void removeList(Alcohols value) {
    _AlcoholList.remove(value);
    notifyListeners();
  }
}
