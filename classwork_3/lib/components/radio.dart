import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String value;
  final String groupValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Text(value),
      ],
    );
  }
}
