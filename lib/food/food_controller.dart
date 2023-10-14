import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'food.dart';
import 'food_service.dart';

part 'food_controller.g.dart';

@riverpod
FutureOr<FoodState> foods(FoodsRef ref) async {
  final service = ref.watch(foodServiceProvider);
  final f = await service.findAll();
  return FoodState(foods: f, count: 0, filteredFoods: f);
}

@riverpod
class FoodController extends _$FoodController {
  late FoodService _service;

  @override
  Future<FoodState> build() async {
    _service = ref.watch(foodServiceProvider);
    final state = await ref.watch(foodsProvider.future);
    return state;
  }

  void applyFilter() {
    update((state) {
      final filtered = state.foods.where((element) => element.name == 'Pippo');
      return FoodState(foods: state.foods, filteredFoods: [...filtered], count: 1);
    });
  }
}

class FoodState {
  FoodState({
    required this.foods,
    required this.filteredFoods,
    required this.count,
  });
  final List<Food> foods;
  final List<Food> filteredFoods;
  final int count;
}
