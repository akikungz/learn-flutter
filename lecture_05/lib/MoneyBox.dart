import 'package:flutter/material.dart';

// function to locate string resources
String toLocate(double amount) {
  return amount
      .toStringAsFixed(3)
      .replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
}

class MoneyBox extends StatefulWidget {
  final String title;
  final double amount;
  final Color color;
  final Color textColor;

  const MoneyBox({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  State<MoneyBox> createState() => _MoneyBoxState();
}

class _MoneyBoxState extends State<MoneyBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(color: widget.textColor, fontSize: 24),
          ),
          Text(
            '${toLocate(widget.amount)}฿',
            style: TextStyle(color: widget.textColor, fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  const TextInput({super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Account Name',
          border: InputBorder.none,
          icon: Icon(Icons.account_circle),
        ),
      ),
    );
  }
}
