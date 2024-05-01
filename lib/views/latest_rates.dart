import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LatestRates extends StatelessWidget {
  final List<dynamic> exchangeRates;
  final String baseCurrency;
  final String baseCode;
  const LatestRates(
      {super.key,
      required this.exchangeRates,
      required this.baseCurrency,
      required this.baseCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Latest Exchange Rates",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$baseCurrency - ($baseCode)",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: exchangeRates.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0).copyWith(
                            bottom: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor:
                                        const Color.fromARGB(255, 8, 0, 101),
                                    child: Text(
                                      exchangeRates[index]["symbol"].toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      exchangeRates[index]["name"].toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Exchange Rate: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade300,
                                    ),
                                  ),
                                  Text(
                                    exchangeRates[index]["value"].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              exchangeRates[index]["countries"].length > 1
                                  ? const Divider()
                                  : const SizedBox(),
                              exchangeRates[index]["countries"].length > 1
                                  ? const Text(
                                      "Countries being used",
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    )
                                  : const SizedBox(),
                              exchangeRates[index]["countries"].length > 1
                                  ? const SizedBox(
                                      height: 5,
                                    )
                                  : const SizedBox(),
                              exchangeRates[index]["countries"].length > 1
                                  ? Wrap(
                                      runSpacing: 0,
                                      spacing: 8,
                                      children: (exchangeRates[index]
                                              ["countries"] as List)
                                          .map((country) {
                                        return Chip(
                                          label: Text(
                                            country.toString(),
                                          ),
                                          labelStyle: const TextStyle(
                                            fontSize: 12,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
