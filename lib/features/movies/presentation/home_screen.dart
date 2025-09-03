import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/movie_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(moviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Bonie'),
      ),
      // moviesAsyncValue의 상태에 따라 다른 위젯을 보여줌
      body: moviesAsyncValue.when(
        data: (movies) {
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: Image.network(movie.poster),
                title: Text(movie.title),
                subtitle: Text(movie.year),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
