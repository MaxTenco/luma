import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'food.dart';
import 'food_controller.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  List<Widget> _list(List<Food> foods) {
    return List.generate(
      foods.length,
      (index) => Text(foods[index].name),
    );
  }

  Widget _body(WidgetRef ref, List<Food> foods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 80),
        ElevatedButton(
          onPressed: () {
            ref.read(foodControllerProvider.notifier).applyFilter();
          },
          child: const Text('Press Me'),
        ),
        const SizedBox(height: 80),
        ..._list(foods),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foods = ref.watch(foodControllerProvider);

    return Scaffold(
      body: foods.when(
        data: (data) => _body(ref, data.foods),
        error: (error, s) => Container(),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
