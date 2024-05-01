import 'package:exchange_ease/providers/currencies.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';

class SelectCurrencies extends StatefulWidget {
  final List<dynamic> currencies;
  const SelectCurrencies({super.key, required this.currencies});

  @override
  State<SelectCurrencies> createState() => _SelectCurrenciesState();
}

class _SelectCurrenciesState extends State<SelectCurrencies> {
  @override
  Widget build(BuildContext context) {
    return MultiSelectFormField(
      dataSource: widget.currencies,
      textField: 'name',
      valueField: 'code',
      fillColor: Colors.black87,
      checkBoxActiveColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          "Select Currencies",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      hintWidget: const Text(
        "Tap to select one or more",
        style: TextStyle(
          fontSize: 15,
          color: Colors.white70,
        ),
      ),
      onSaved: (value) {
        Provider.of<CurrencyProvider>(context, listen: false)
            .setCurrencies(value);
      },
    );
  }
}
