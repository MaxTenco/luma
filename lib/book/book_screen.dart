import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'book_controller.dart';
import 'book_details.dart';

class BookScreen extends ConsumerWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(bookControllerProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          switch (controller) {
            AsyncData(:final value) => BookDetails(value),
            _ => const SizedBox(),
          },
          const SizedBox(height: 36),
          TextButton(
            onPressed: () {
              ref.read(bookControllerProvider.notifier).onNextTap();
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
