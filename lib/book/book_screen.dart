import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'book.dart';
import 'book_details.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  static const _books = [
    Book(title: 'Harry Potter'),
    Book(title: 'The Lord of the Rings'),
    Book(title: 'IT'),
  ];

  var _currentBook = _books.sample(1).single;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BookDetails(_currentBook),
          const SizedBox(height: 36),
          TextButton(
            onPressed: _setState,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  void _setState() {
    setState(() {
      _currentBook = _books.sample(1).single;
    });
  }
}
