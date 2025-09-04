import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_bonie/features/movies/domain/movie.dart';

// NotifierProvider 생성. "좋아요" 목록을 관리할 Notifier를 제공
final favoritesProvider =
    NotifierProvider<FavoritesNotifier, List<Movie>>(FavoritesNotifier.new);

// "좋아요" 목록의 상태를 관리하는 Notifier 클래스
class FavoritesNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() {
    // 초기 상태는 빈 목록
    return [];
  }

  // 영화를 "좋아요" 목록에 추가하거나 제거하는 메서드
  void toggleFavorite(Movie movie) {
    // 현재 "좋아요" 목록에 해당 영화가 포함되어 있는지 확인
    final isFavorite = state.any((m) => m.imdbID == movie.imdbID);

    if (isFavorite) {
      // 이미 있다면, 목록에서 제거
      state = state.where((m) => m.imdbID != movie.imdbID).toList();
    } else {
      // 없다면, 목록에 추가
      state = [...state, movie];
    }
  }
}
