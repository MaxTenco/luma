import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'imperative_approach.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foods = ref.watch(filteredFoodControllerProvider);

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
              onRefresh: () async {
                ref.invalidate(filteredFoodControllerProvider);
              },
              child: ListView(
                children: [
                  const SizedBox(height: 80),
                  TextField(
                    onChanged: (value) {
                      ref.read(filteredFoodControllerProvider.notifier).filter(value);
                      ref.read(filteredFoodControllerProvider.notifier).onTextChange(value);
                    },
                    decoration: InputDecoration(
                      prefixIcon:
                          foods.asData?.value.showButton ?? false ? const Icon(Icons.check) : null,
                      suffixIcon: IconButton(
                        onPressed: ref.read(filteredFoodControllerProvider.notifier).clear,
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  ...foods.when(
                    data: (data) => List.generate(
                      data.foods.length,
                      (index) => Text(data.foods[index].name),
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
