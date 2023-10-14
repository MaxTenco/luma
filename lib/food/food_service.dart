import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'food.dart';

part 'food_service.g.dart';

@riverpod
FoodService foodService(FoodServiceRef ref) {
  return FoodService();
}

class FoodService {
  Future<List<Food>> findAll() async {
    await Future<void>.delayed(const Duration(seconds: 6));
    return [
      Food(name: 'Pizza'),
      Food(name: 'Pasta'),
      Food(name: 'Riso'),
    ];
  }
}
