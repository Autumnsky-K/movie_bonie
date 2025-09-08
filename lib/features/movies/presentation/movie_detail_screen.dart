import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/movie_providers.dart';
import 'providers/favorites_provider.dart';
import 'package:movie_bonie/features/movies/domain/movie.dart';

class MovieDetailScreen extends ConsumerWidget {
  final String id; // 라우터로부터 전달받을 영화 ID
  const MovieDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // id를 사용하여 movieDetailProvider를 구독
    final movieDetailAsyncValue = ref.watch(movieDetailProvider(id));
    // "좋아요" 목록 상태를 감시
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: movieDetailAsyncValue.when(
            data: (movieDetail) => Text(movieDetail.title),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink()),
        actions: [
          movieDetailAsyncValue.when(
            data: (movieDetail) {
              // AsyncValue에서 실제 데이터 리스트를 추출
              // 데이터가 로딩 중이거나 에러 상태일 경우, .value는 null 이므로 빈 리스트를 대신 사용.
              final favorites = favoritesAsync.value ?? [];
              // 현재 영화가 "좋아요" 목록에 있는지 확인
              final isFavorite =
                  favorites.any((m) => m.imdbID == movieDetail.imdbID);
              return Padding(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () {
                    // 상세 정보 (MovieDetail)에서 목록에 필요한 정보 (Movie)만으로 객체를 생성
                    final movie = Movie(
                      title: movieDetail.title,
                      year: movieDetail.year,
                      imdbID: movieDetail.imdbID,
                      type: movieDetail.type,
                      poster: movieDetail.poster,
                    );
                    // Notifier의 메서드를 호출하여 상태를 변경
                    ref.read(favoritesProvider.notifier).toggleFavorite(movie);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(), // 로딩 중에는 버튼 숨김
            error: (_, __) => const SizedBox.shrink(), // 에러 시 버튼 숨김
          ),
        ],
      ),
      body: movieDetailAsyncValue.when(
        data: (movie) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 포스터 이미지
              Image.network(movie.poster),
              const SizedBox(height: 16),
              // 제목
              Text(movie.title,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              // 연도, 장르
              Text('${movie.year} / ${movie.genre}'),
              const SizedBox(height: 16),
              // 줄거리
              Text(movie.plot),
              const SizedBox(height: 16),
              // 감독
              Text('감독: ${movie.director}'),
              // 배우
              Text('배우: ${movie.actors}'),
              // 평점
              Text('IMDb 평점: ${movie.imdbRating}'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('오류가 발생했습니다: $err')),
      ),
    );
  }
}
