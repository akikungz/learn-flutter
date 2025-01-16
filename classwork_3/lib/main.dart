import 'package:classwork_3/components/input.dart';
import 'package:classwork_3/components/radio.dart';
import 'package:classwork_3/pages/circle.dart';
import 'package:classwork_3/pages/rectangle.dart';
import 'package:classwork_3/pages/triangle.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Geometric Area Calculator'),
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
  String gValue = 'Rectangle';

  TextEditingController heightC = TextEditingController();
  TextEditingController widthC = TextEditingController();
  TextEditingController baseC = TextEditingController();
  TextEditingController radiusC = TextEditingController();

  void _handleRadioValueChange(String? value) {
    setState(() {
      gValue = value!;
    });

    heightC.clear();
    widthC.clear();
    baseC.clear();
    radiusC.clear();
  }

  bool validate() {
    // not empty and not null and not negative and not zero and not string
    if (gValue == "Rectangle") {
      return heightC.text.isNotEmpty &&
          widthC.text.isNotEmpty &&
          int.tryParse(heightC.text) != null &&
          int.tryParse(widthC.text) != null &&
          int.parse(heightC.text) > 0 &&
          int.parse(widthC.text) > 0;
    } else if (gValue == "Triangle") {
      return baseC.text.isNotEmpty &&
          heightC.text.isNotEmpty &&
          int.tryParse(baseC.text) != null &&
          int.tryParse(heightC.text) != null &&
          int.parse(baseC.text) > 0 &&
          int.parse(heightC.text) > 0;
    } else {
      return radiusC.text.isNotEmpty &&
          int.tryParse(radiusC.text) != null &&
          int.parse(radiusC.text) > 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: <Widget>[
            CustomRadio(
              value: 'Rectangle',
              groupValue: gValue,
              onChanged: _handleRadioValueChange,
            ),
            CustomRadio(
              value: 'Triangle',
              groupValue: gValue,
              onChanged: _handleRadioValueChange,
            ),
            CustomRadio(
              value: 'Circle',
              groupValue: gValue,
              onChanged: _handleRadioValueChange,
            ),
            SizedBox(height: 8),
            gValue == "Rectangle"
                ? Column(
                  children: [
                    CustomInput(
                      controller: heightC,
                      label: 'Height',
                      keyboardType: TextInputType.number,
                    ),
                    CustomInput(
                      controller: widthC,
                      label: 'Width',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )
                : gValue == "Triangle"
                ? Column(
                  children: [
                    CustomInput(
                      controller: baseC,
                      label: 'Base',
                      keyboardType: TextInputType.number,
                    ),
                    CustomInput(
                      controller: heightC,
                      label: 'Height',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )
                : CustomInput(
                  controller: radiusC,
                  label: 'Radius',
                  keyboardType: TextInputType.number,
                ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (!validate()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter valid values'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                if (gValue == "Rectangle") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => RectangleResult(
                            width: int.parse(widthC.text),
                            height: int.parse(heightC.text),
                          ),
                    ),
                  );
                } else if (gValue == "Triangle") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TriangleResult(
                            base: int.parse(baseC.text),
                            height: int.parse(heightC.text),
                          ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              CircleResult(radius: int.parse(radiusC.text)),
                    ),
                  );
                }
              },
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}
