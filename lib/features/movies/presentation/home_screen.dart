import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_bonie/features/movies/presentation/widgets/movie_card.dart';

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
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            // 그리드의 한 아이템이 차지할 영역에 대한 설정
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.6,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              // ListTile 대신 MovieCard를 사용
              return MovieCard(movie: movie);
            },
          );
          // return ListView.builder(
          //   itemCount: movies.length,
          //   itemBuilder: (context, index) {
          //     final movie = movies[index];
          //     return ListTile(
          //       leading: Image.network(movie.poster),
          //       title: Text(movie.title),
          //       subtitle: Text(movie.year),
          //     );
          //   },
          // );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
