import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 150, 236, 255),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 150, 236, 255),
          title: const Text('Flutter Demo'),
        ),
        body: NumberWidget(),
      ),
    );
  }
}

// StatefulWidget
class NumberWidget extends StatefulWidget {
  const NumberWidget({super.key});

  @override
  State<NumberWidget> createState() => _NumberWidgetState();
}

class _NumberWidgetState extends State<NumberWidget> {
  int _number = 0;

  void _increment() {
    setState(() {
      _number++;
    });
  }

  void _decrement() {
    setState(() {
      _number--;
    });
  }

  void _reset() {
    setState(() {
      _number = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_number', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _increment,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _decrement,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _reset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.refresh),
                SizedBox(height: 4),
                Text('Reset'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
