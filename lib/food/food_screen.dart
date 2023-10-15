import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'declarative_approach.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final foods = ref.watch(filteredFoodControllerProvider);
    final foods = ref.watch(FoodState.filteredFoods);
    final showButton = ref.watch(FoodState.showButton);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (foods case AsyncLoading()) return false;
          return true;
        },
        child: Stack(
          children: [
            if (foods.isLoading && !foods.isReloading)
              const Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: ColoredBox(
                    color: Colors.red,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            RefreshIndicator(
              onRefresh: () {
                ref.invalidate(FoodState.foods);
                return ref.read(FoodState.foods.future);
              },
              child: ListView(
                children: [
                  const SizedBox(height: 80),
                  TextField(
                    onChanged: ref.read(FoodState.filtersController).onChange,
                    decoration: InputDecoration(
                      prefixIcon: showButton ? const Icon(Icons.check) : null,
                      suffixIcon: IconButton(
                        onPressed: ref.read(FoodState.filtersController).clear,
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  ...foods.when(
                    data: (data) => List.generate(
                      data.length,
                      (index) => Text(data[index].name),
                    ),
                    error: (error, s) => [Container()],
                    loading: () => [Container()],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





/*
  screen --> filtered
  filtri --> screen
  filtered --> filtri
*/
