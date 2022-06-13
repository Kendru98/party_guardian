import 'package:flutter/material.dart';

class Manage extends ChangeNotifier {
  String _select = '';

  String get select => _select;

  void setselect(String value) {
    _select = value;

    notifyListeners();
  }
}
