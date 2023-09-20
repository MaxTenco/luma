import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          controller.when(
            data: (data) {
              return BookDetails(book: data);
            },
            error: (error, _) => const Text('Error'),
            loading: () => const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
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
