import 'package:flutter/material.dart';

void main() => runApp(CurrencyConverterApp());

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Currency Converter', home: CurrencyConverter());
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _controller = TextEditingController();
  double? _inputAmount;
  double? _usd, _yen, _euro;

  // ตัวอย่างอัตราแลกเปลี่ยน (อัปเดตได้ตามความต้องการ)
  final double _usdRate = 0.028; // 1 THB = 0.028 USD
  final double _yenRate = 3.78; // 1 THB = 3.78 JPY
  final double _euroRate = 0.025; // 1 THB = 0.025 EUR

  void _convertCurrency() {
    setState(() {
      _inputAmount = double.tryParse(_controller.text);
      if (_inputAmount != null) {
        _usd = _inputAmount! * _usdRate;
        _yen = _inputAmount! * _yenRate;
        _euro = _inputAmount! * _euroRate;
      } else {
        _usd = _yen = _euro = null; // รีเซ็ตค่าเมื่อใส่ตัวเลขผิด
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currency Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter amount in THB',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _convertCurrency, child: Text('Convert')),
            SizedBox(height: 16),
            if (_usd != null && _yen != null && _euro != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('USD: ${_usd!.toStringAsFixed(2)}'),
                  Text('YEN: ${_yen!.toStringAsFixed(2)}'),
                  Text('EURO: ${_euro!.toStringAsFixed(2)}'),
                ],
              )
            else if (_controller.text.isNotEmpty)
              Text(
                'Please enter a valid number',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
