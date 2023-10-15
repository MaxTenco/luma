import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'food.dart';
import 'food_service.dart';

part 'declarative_approach.g.dart';

// state aggregator / facade
final class FoodState {
  static final foods = foodsProvider;
  static final filters = foodFilterControllerProvider;
  static final filtersController = foodFilterControllerProvider.notifier;
  static final filteredFoods = filteredFoodsProvider;
  static final showButton = showButtonProvider;
}

// granular, riverpod-style approaches from here below
@riverpod
FutureOr<List<Food>> foods(FoodsRef ref) {
  return ref.watch(foodServiceProvider).findAll();
}

@riverpod
class FoodFilterController extends _$FoodFilterController {
  @override
  String build() {
    return '';
  }

  void onChange(String? input) {
    if (input == null) return;
    state = input;
  }

  void clear() => state = '';
}

@riverpod
bool showButton(ShowButtonRef ref) {
  final filter = ref.watch(foodFilterControllerProvider);

  return filter == 'Paperino';
}

@riverpod
FutureOr<List<Food>> filteredFoods(FilteredFoodsRef ref) async {
  final foods = await ref.watch(foodsProvider.future);
  final filter = ref.watch(foodFilterControllerProvider);

  return [
    ...foods.where(
      (food) => food.name.toLowerCase().contains(filter.toLowerCase()),
    ),
  ];
}
