import 'package:flutter/material.dart';
import 'package:party_guardian/models/alcohol_model.dart';

class Manage extends ChangeNotifier {
  List<Alcohols> _AlcoholList = [];

  get AlcoholList => _AlcoholList;

  void addList(Alcohols value) {
    _AlcoholList.add(value);

    notifyListeners();
  }

  void removeList(Alcohols value) {
    _AlcoholList.remove(value);
    notifyListeners();
  }
}
