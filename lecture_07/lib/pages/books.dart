import 'package:flutter/material.dart';
import 'package:lecture_07/pages/books/create.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Create()),
                );
              },
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.add, size: 24),
                    const SizedBox(width: 8),
                    Text('Create book'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
