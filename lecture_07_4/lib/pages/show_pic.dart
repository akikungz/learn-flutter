import 'package:flutter/material.dart';

class ShowPic extends StatefulWidget {
  const ShowPic({super.key});

  @override
  _ShowPicState createState() => _ShowPicState();
}

class _ShowPicState extends State<ShowPic> {
  String _selectedPic = 'assets/images/image_1.gif';

  void changeImage(String pic) {
    setState(() {
      _selectedPic = pic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Show Picture')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(_selectedPic, width: 300, height: 200),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => changeImage('assets/images/image_1.gif'),
                  child: const Text('Pic 1'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => changeImage('assets/images/image_2.gif'),
                  child: const Text('Pic 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
