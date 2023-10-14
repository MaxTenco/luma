import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'food.dart';
import 'food_service.dart';

part 'imperative_approach.g.dart';

@riverpod
class FilteredFoodController extends _$FilteredFoodController {
  late FoodService _service;
  late List<Food> _original;
  @override
  FutureOr<Entity> build() async {
    _service = ref.watch(foodServiceProvider);
    final foods = await _service.findAll();
    _original = foods;
    return Entity(foods);
  }

  void filter(String input) {
    update(
      (state) => Entity(
        [
          ..._original.where(
            (element) => element.name.toLowerCase().contains(input.toLowerCase()),
          ),
        ],
        showButton: state.showButton,
      ),
    );
  }

  void clear() {
    state = AsyncData(Entity(_original));
  }

  void onTextChange(String value) {
    update((state) => Entity(state.foods, showButton: value == 'Paperino'));
  }
}

class Entity {
  Entity(this.foods, {this.showButton = false});
  final List<Food> foods;
  bool showButton;
}
