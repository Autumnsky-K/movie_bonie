import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_bonie/features/movies/presentation/providers/favorites_provider.dart';
import 'package:movie_bonie/features/movies/presentation/widgets/movie_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // "좋아요" 목록 상태를 가져오기.
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 보관함'),
      ),
      body: favoritesAsync.when(
        data: (favorites) {
          // 데이터 로딩 성공 시
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                '아직 좋아요한 영화가 없어요!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          // 목록이 있을 경우 GridView로 표시
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final movie = favorites[index];
              return GestureDetector(
                onTap: () => context.push('/movie/${movie.imdbID}'),
                child: MovieCard(movie: movie),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Center(
          child: Text('오류가 발생했습니다: $err'),
        ),
      ),
    );
  }
}
