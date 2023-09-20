import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'book.dart';

part 'book_controller.g.dart';

@riverpod
class BookController extends _$BookController {
  final _books = [
    Book(title: 'Harry Potter'),
    Book(title: 'The Lord of the Rings'),
    Book(title: 'IT'),
  ];

  @override
  FutureOr<Book> build() async {
    return _books.sample(1).single;
  }

  Future<void> onNextTap() async {
    print('Setting state to `loading`');
    state = const AsyncLoading();
    print('Setting state to `data`');
    state = AsyncData(_books.sample(1).single);
  }
}
