import 'package:luma/book/book.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    return (_books..shuffle()).first;
  }

  void onNextTap() {
    final book = (_books..shuffle()).first;
    state = AsyncData(book);
  }
}
