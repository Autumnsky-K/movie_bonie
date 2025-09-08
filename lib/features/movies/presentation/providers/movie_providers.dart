import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/movie_repository.dart';
import '../../domain/movie.dart';
import '../../domain/movie_detail.dart';

const String initialSearchQuery = 'star';

// 검색어를 관리하는 StateProvider
final searchQueryProvider = StateProvider<String>((ref) => initialSearchQuery);

// '.family'를 사용하여 파라미터(query)를 받을 수 있는 FutureProvider를 생성
final moviesProvider = FutureProvider.family<List<Movie>, String>((ref, query) {
  // movieRepositoryProvider를 참조하여 repository 인스턴스를 가져옴
  final repository = ref.watch(movieRepositoryProvider);
  // repository의 fetchMovies 메서드를 호출하여 영화 목록을 가져옴
  // 'star'는 초기 검색어로, 나중에 원하는 값으로 변경 가능
  return repository.fetchMovies(query);
});

// '.family'를 사용하여 파라미터(id)를 받을 수 있는 FutureProvider를 생성
final movieDetailProvider =
    FutureProvider.family<MovieDetail, String>((ref, id) {
  // movieRepositoryProvider를 참조
  final repository = ref.watch(movieRepositoryProvider);
  // 주어진 id를 사용하여 특정 영화의 상세 정보를 가져옴
  return repository.fetchMovieDetail(id);
});
