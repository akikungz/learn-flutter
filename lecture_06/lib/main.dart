import 'package:flutter/material.dart';

void main() {
  runApp(const Lecture06());
}

class Lecture06 extends StatelessWidget {
  const Lecture06({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lecture 06',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Lecture 06'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Widget items state
  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Radio check box
            Row(
              children: [
                Radio(
                  value: 'test1',
                  groupValue: 'test',
                  onChanged: (value) {},
                ),
                Text('Test 1'),
                Radio(
                  value: 'test2',
                  groupValue: 'test',
                  onChanged: (value) {},
                ),
                Text('Test 2'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
