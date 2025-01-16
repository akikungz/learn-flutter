import 'package:flutter/material.dart';

class TriangleResult extends StatefulWidget {
  const TriangleResult({super.key, required this.base, required this.height});

  final int base;
  final int height;

  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<TriangleResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Triangle Area'),
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
            Text('Base: ${widget.base}', style: TextStyle(fontSize: 32)),
            Text('Height: ${widget.height}', style: TextStyle(fontSize: 32)),
            Text(
              'Area: ${widget.base * widget.height / 2}',
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
