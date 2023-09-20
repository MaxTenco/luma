import 'package:flutter/material.dart';

import 'book.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool _showTitle = false;

  @override
  Widget build(BuildContext context) {
    return _showTitle
        ? Center(
            child: Text(widget.book.title),
          )
        : TextButton(
            onPressed: () {
              setState(() {
                _showTitle = true;
              });
            },
            child: const Text('Show title'),
          );
  }
}