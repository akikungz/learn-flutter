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
    'KTB': {'USD': 35.1, 'JPY': 0.32, 'EUR': 40.5},
    'SCB': {'USD': 35.3, 'JPY': 0.35, 'EUR': 40.2},
    'TMB': {'USD': 35.5, 'JPY': 0.37, 'EUR': 40.7},
  };

  @override
  Widget build(BuildContext context) {
    String total = toLocate(
      widget.amount / (exchange[widget.bank][widget.currency] as double),
    );

    String bank = widget.bank;
    String currency = widget.currency;

    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: Center(
        child: Column(
          children: [
            Text(bank, style: TextStyle(fontSize: 32)),
            Text('$total $currency'),
          ],
        ),
      ),
    );
  }
}

String toLocate(double amount) {
  return amount
      .toStringAsFixed(2)
      .replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
}
