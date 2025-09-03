import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/movie_providers.dart';

class MovieDetailScreen extends ConsumerWidget {
  final String id; // 라우터로부터 전달받을 영화 ID

  const MovieDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // id를 사용하여 movieDetailProvider를 구독
    final movieDetailAsyncValue = ref.watch(movieDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Detail'),
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
              Text('Director: ${movie.director}'),
              // 배우
              Text('Actors: ${movie.actors}'),
              // 평점
              Text('IMDb Rating: ${movie.imdbRating}'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
