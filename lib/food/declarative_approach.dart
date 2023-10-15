import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'food.dart';
import 'food_service.dart';

part 'declarative_approach.g.dart';

// state aggregator / facade
final class FoodState {
  final foods = foodsProvider;
  final filters = foodFilterControllerProvider;
  final filtersController = foodFilterControllerProvider.notifier;
  final filteredFoods = filteredFoodsProvider;
  final showButton = showButtonProvider;
}

final foodState = FoodState();

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
