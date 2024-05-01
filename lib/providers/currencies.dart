import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  List<dynamic> currencies = [];
  void setCurrencies(List<dynamic> selectedCurrencies) {
    currencies = selectedCurrencies;
    notifyListeners();
  }
}
