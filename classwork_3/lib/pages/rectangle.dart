import 'package:flutter/material.dart';

class RectangleResult extends StatefulWidget {
  const RectangleResult({super.key, required this.width, required this.height});

  final int width;
  final int height;

  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<RectangleResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rectangle Area'),
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
            Text('Width: ${widget.width}', style: TextStyle(fontSize: 32)),
            Text('Height: ${widget.height}', style: TextStyle(fontSize: 32)),
            Text(
              'Area: ${widget.width * widget.height}',
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
