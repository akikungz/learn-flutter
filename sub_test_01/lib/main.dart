import 'package:flutter/material.dart';
import 'package:sub_test_01/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int amount = 0;
  String bank = 'KTB';
  String currency = 'USD';

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currency Converter')),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter amount in Thai baht',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => amount = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 8),
            Text('Select bank'),
            DropdownButtonFormField<String>(
              value: bank,
              items:
                  ['KTB', 'SCB', 'TMB']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (value) => bank = value ?? '',
              decoration: InputDecoration(
                labelText: 'Select bank',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Text('Select Currency'),
            Row(
              children: [
                Radio<String>(
                  value: 'USD',
                  groupValue: currency,
                  onChanged: (value) {
                    setState(() {
                      currency = value ?? '';
                    });
                  },

                  // default
                ),
                Text('USD'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'JPY',
                  groupValue: currency,
                  onChanged: (value) {
                    setState(() {
                      currency = value ?? '';
                    });
                  },
                ),
                Text('JPY'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'EUR',
                  groupValue: currency,
                  onChanged: (value) {
                    setState(() {
                      currency = value ?? '';
                    });
                  },
                ),
                Text('EUR'),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Result(
                          amount: amount,
                          bank: bank,
                          currency: currency,
                        ),
                  ),
                );
              },
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
