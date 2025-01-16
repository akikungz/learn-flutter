import 'package:flutter/material.dart';
import 'package:lecture_07_4/pages/page_1.dart';
import 'package:lecture_07_4/pages/page_2.dart';
import 'package:lecture_07_4/pages/show_pic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
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
  Widget _currentPage = const Page1();

  void _changePage(Widget page) {
    setState(() {
      _currentPage = page;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _currentPage,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Page 1'),
              onTap: () => _changePage(const Page1()),
            ),
            ListTile(
              title: const Text('Page 2'),
              onTap: () => _changePage(const Page2()),
            ),
            ListTile(
              title: const Text('Show Picture'),
              onTap: () => _changePage(const ShowPic()),
            ),
          ],
        ),
      ),
    );
  }
}
