import 'package:flutter/material.dart';
import 'package:lecture_5/MoneyBox.dart';

void main() {
  runApp(const Lecture5());
}

class Lecture5 extends StatelessWidget {
  const Lecture5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lecture 5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Lecture 5'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextInput(),
              MoneyBox(
                title: 'ยอดคงเหลือ',
                amount: 30000.512,
                color: Colors.blue,
              ),
              MoneyBox(title: 'รายรับ', amount: 10000, color: Colors.green),
              MoneyBox(title: 'รายจ่าย', amount: 80000, color: Colors.red),
              MoneyBox(
                title: 'ค้างจ่าย',
                amount: 4000,
                color: Colors.yellow,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
