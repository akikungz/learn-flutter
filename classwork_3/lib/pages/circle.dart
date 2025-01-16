import 'package:flutter/material.dart';

class CircleResult extends StatefulWidget {
  const CircleResult({super.key, required this.radius});

  final int radius;

  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<CircleResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circle Area'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Radius: ${widget.radius}', style: TextStyle(fontSize: 32)),
            Text(
              'Area: ${widget.radius * widget.radius * 3.14}',
              style: TextStyle(fontSize: 32),
            ),
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
