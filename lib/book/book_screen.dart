import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'book.dart';
import 'book_details.dart';
import 'book_ui_state.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  var _stateUi = const BookUiState.loading();
  static const _books = [
    Book(title: 'Harry Potter'),
    Book(title: 'The Lord of the Rings'),
    Book(title: 'IT'),
  ];

  @override
  Widget build(BuildContext context) {
    print('Parent has been rebuilt; hashes: $hashCode, ${widget.hashCode}');

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: _stateUi.when(
              results: BookDetails.new,
              loading: CircularProgressIndicator.new,
            ),
          ),
          const SizedBox(height: 36),
          TextButton(
            onPressed: () async {
              setState(() {
                _stateUi = const BookUiState.loading();
              });
              await Future<void>.delayed(const Duration(microseconds: 500));
              setState(() {
                _stateUi = BookUiState.results(_books.sample(1).single);
              });
            },
            child: const Text('Compute'),
          ),
        ],
      ),
    );
  }
}
