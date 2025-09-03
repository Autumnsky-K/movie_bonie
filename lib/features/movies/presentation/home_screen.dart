import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_bonie/features/movies/presentation/widgets/movie_card.dart';

import 'providers/movie_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. searchQueryProvider를 watch하여 현재 검색어를 가져오기
    final searchQuery = ref.watch(searchQueryProvider);
    // 2. 현재 검색어(searchQuery)를 moviesProvider.family에 전달하여 영화 목록 가져오기
    final moviesAsyncValue = ref.watch(moviesProvider(searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Bonie'),
      ),
      // moviesAsyncValue의 상태에 따라 다른 위젯을 보여줌
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(),
              ),
              // 3. TextField의 값이 변경될 때마다 searchQueryProvider의 상태 업데이트
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
            ),
          ),
          Expanded(
            child: moviesAsyncValue.when(
              data: (movies) {
                if (movies.isEmpty) {
                  return const Center(child: Text('No movies found.'));
                }
                return GridView.builder(
                  // key를 추가하여 검색 결과가 바뀔 때 GridView를 새로 그리기
                  key: ValueKey(searchQuery),
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
          ),
        ],
      ),
    );
  }
}
