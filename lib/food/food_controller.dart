import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'food.dart';
import 'food_service.dart';

part 'food_controller.g.dart';

@riverpod
class FoodController extends _$FoodController {
  late FoodService _service;

  @override
  Future<_State> build() async {
    _service = ref.watch(foodServiceProvider);
    final foods = await _service.findAll();
    return _State(foods: foods, count: 0);
  }

  void applyFilter() {}
}

class _State {
  _State({
    required this.foods,
    required this.count,
  });

  final List<Food> foods;
  final int count;
}
