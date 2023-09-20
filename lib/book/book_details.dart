import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'book.dart';

class BookDetails extends HookWidget {
  const BookDetails(
    this.book, {
    super.key,
  });
  final Book book;

  @override
  Widget build(BuildContext context) {
    final showTitle = useState(false);

    return showTitle.value
        ? Center(child: Text(book.title))
        : TextButton(
            onPressed: () => showTitle.value = !showTitle.value,
            child: const Text('Show title'),
          );
  }
}
