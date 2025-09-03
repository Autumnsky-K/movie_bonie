import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/movie_repository.dart';
import '../../domain/movie.dart';

// 영화 목록을 비동기적으로 가져오는 FutureProvider
final moviesProvider = FutureProvider<List<Movie>>((ref) {
  // movieRepositoryProvider를 참조하여 repository 인스턴스를 가져옴
  final repository = ref.watch(movieRepositoryProvider);
  // repository의 fetchMovies 메서드를 호출하여 영화 목록을 가져옴
  // 'star'는 초기 검색어로, 나중에 원하는 값으로 변경 가능
  return repository.fetchMovies('star');
});
