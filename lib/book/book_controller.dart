import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'book.dart';

part 'book_controller.g.dart';

@riverpod
class BookController extends _$BookController {
  static const _books = [
    Book(title: 'Harry Potter'),
    Book(title: 'The Lord of the Rings'),
    Book(title: 'IT'),
  ];

  @override
  FutureOr<Book> build() async {
    return _books.sample(1).single;
  }

  void onNextTap() {
    final book = _books.sample(1).single;
    state = AsyncData(book);
  }
}
