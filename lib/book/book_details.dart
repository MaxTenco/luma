import 'package:flutter/material.dart';

import 'book.dart';

class BookDetails extends StatefulWidget {
  const BookDetails(
    this.book, {
    super.key,
  });
  final Book book;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    print('Child has been initialized: hello, ${widget.hashCode}');
  }

  @override
  void dispose() {
    print('Child has been disposed: goodbye, ${widget.hashCode}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Child has been rebuilt; hashes: $hashCode, ${widget.hashCode}');
    return _showTitle
        ? Center(child: Text(widget.book.title))
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
