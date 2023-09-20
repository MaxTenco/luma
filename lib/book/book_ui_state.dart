import 'package:freezed_annotation/freezed_annotation.dart';

import 'book.dart';

part 'book_ui_state.freezed.dart';

@freezed
sealed class BookUiState with _$BookUiState {
  const factory BookUiState.results(Book data) = Results;
  const factory BookUiState.loading() = Loading;
}
