import 'dart:convert';

import 'package:exchange_ease/providers/currencies.dart';
import 'package:exchange_ease/secrets/api_key.dart';
import 'package:exchange_ease/views/latest_rates.dart';
import 'package:exchange_ease/widgets/base_currency.dart';
import 'package:exchange_ease/widgets/select_currencies.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _currencies = [];
  String _baseCurrency = "";
  String _baseCode = "";

  Future getCurrencies() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.currencyapi.com/v3/currencies?apikey=$apiKey"));

      if (response.statusCode == 200) {
        final currencies = jsonDecode(response.body);
        _currencies = currencies["data"].values.map((data) {
          return {
            "name": data["name"],
            "code": data["code"],
            "type": data["type"],
            "countries": data["countries"],
            "symbol": data["symbol"],
          };
        }).toList();
        setState(() {
          _baseCurrency = currencies["data"].values.first["name"];
          _baseCode = currencies["data"].values.first["code"];
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getExchangeRates() async {
    try {
      List<dynamic> selectedCurrencyCodes =
          Provider.of<CurrencyProvider>(context, listen: false).currencies;
      String codes = "";
      for (var code in selectedCurrencyCodes) {
        codes = "${codes}currencies[]=${code.toString()}&";
      }
      final response = await http.get(Uri.parse(
          "https://api.currencyapi.com/v3/latest?base_currency=$_baseCode&${codes}apikey=$apiKey"));
      if (response.statusCode == 200) {
        List<dynamic> exchangeRates =
            jsonDecode(response.body)["data"].values.map((data) {
          String name = "";
          String symbol = "";
          String type = "";
          List<dynamic> countries = [];
          for (var currency in _currencies) {
            if (currency["code"] == data["code"]) {
              name = currency["name"];
              symbol = currency["symbol"];
              type = currency["type"];
              countries = currency["countries"];
              break;
            }
          }
          return {
            "name": name,
            "code": data["code"],
            "value": data["value"],
            "type": type,
            "countries": countries,
            "symbol": symbol,
          };
        }).toList();
        if (context.mounted) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LatestRates(
                exchangeRates: exchangeRates,
                baseCurrency: _baseCurrency,
                baseCode: _baseCode,
              ),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  @override
  void dispose() {
    Provider.of<CurrencyProvider>(context, listen: false).setCurrencies([]);
    super.dispose();
  }

  void setBaseCurrency(String value) {
    setState(() {
      _baseCurrency = value.toString();
      for (var currency in _currencies) {
        if (currency["name"] == _baseCurrency) {
          _baseCode = currency["code"];
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Exchange Ease",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Base Currency",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BaseCurrency(
                    baseCurrency: _baseCurrency,
                    currencies: _currencies,
                    setBaseCurrency: setBaseCurrency,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SelectCurrencies(currencies: _currencies),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: getExchangeRates,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Get Latest Exchange Rates",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
