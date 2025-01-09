import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<StatefulWidget> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Create Form')),
      body: Center(
        // padding: EdgeInsets.all(8),
        child: Form(
          child: SingleChildScrollView(
            child: Column(children: [Icon(Icons.insert_photo, size: 128)]),
          ),
        ),
      ),
    );
  }
}
