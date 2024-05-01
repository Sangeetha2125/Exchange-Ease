import 'package:flutter/material.dart';

class BaseCurrency extends StatefulWidget {
  final String baseCurrency;
  final List<dynamic> currencies;
  final Function(String) setBaseCurrency;
  const BaseCurrency({
    super.key,
    required this.baseCurrency,
    required this.currencies,
    required this.setBaseCurrency,
  });

  @override
  State<BaseCurrency> createState() => _BaseCurrencyState();
}

class _BaseCurrencyState extends State<BaseCurrency> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.baseCurrency,
      items: widget.currencies.map((e) {
        return DropdownMenuItem(
            value: e["name"],
            child: Text(
              "${e["name"]}",
            ));
      }).toList(),
      onChanged: (value) {
        widget.setBaseCurrency(value.toString());
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
