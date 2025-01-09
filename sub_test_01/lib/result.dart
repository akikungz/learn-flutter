import 'dart:ffi';

import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({
    super.key,
    required this.amount,
    required this.bank,
    required this.currency,
  });
  final int amount;
  final String bank;
  final String currency;

  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map exchange = {
    'KTB': {'USD': 30.1, 'JPY': 0.32, 'EUR': 40},
    'SCB': {'USD': 31.1, 'JPY': 0.35, 'EUR': 40.2},
    'TMB': {'USD': 30.5, 'JPY': 0.37, 'EUR': 39.7},
  };

  @override
  Widget build(BuildContext context) {
    double total =
        widget.amount * (exchange[widget.bank][widget.currency] as double);

    String bank = widget.bank;
    String currency = widget.currency;

    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: Center(child: Column(children: [Text('$bank: $total $currency')])),
    );
  }
}
