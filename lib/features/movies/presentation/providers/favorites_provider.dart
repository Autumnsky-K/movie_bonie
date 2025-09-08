import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_bonie/features/movies/domain/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NotifierProvider 생성. "좋아요" 목록을 관리할 Notifier를 제공
final favoritesProvider = AsyncNotifierProvider<FavoritesNotifier, List<Movie>>(
    FavoritesNotifier.new);

// "좋아요" 목록의 상태를 관리하는 Notifier 클래스
class FavoritesNotifier extends AsyncNotifier<List<Movie>> {
  // SharedPreferences 키를 상수로 관리
  static const String _favoritesKey = 'favorite_movies';

  @override
  Future<List<Movie>> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteMoviesJson = prefs.getStringList(_favoritesKey);

    // 저장된 목록이 없으면 빈 리스트 반환
    if (favoriteMoviesJson == null) {
      return [];
    }

    // 저장된 JSON 문자열 리스트를 다시 Movie 객체 리스트로 변환
    return favoriteMoviesJson
        .map((jsonString) => Movie.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  // 영화를 "좋아요" 목록에 추가하거나 제거하는 메서드
  Future<void> toggleFavorite(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    // 현재 상태는 AsyncValue<List<Movie>>이므로, state.value로 실제 데이터에 접근
    final currentFavorites = state.value ?? [];

    // 현재 "좋아요" 목록에 해당 영화가 포함되어 있는지 확인
    final isFavorite = currentFavorites.any((m) => m.imdbID == movie.imdbID);

    List<Movie> newList;
    if (isFavorite) {
      newList =
          currentFavorites.where((m) => m.imdbID != movie.imdbID).toList();
    } else {
      // 없다면, 목록에 추가
      newList = [...currentFavorites, movie];
    }

    // 상태를 업데이트할 때는 AsyncValue.data()로 감싸주기
    state = AsyncValue.data(newList);

    // 변경된 최신 목록을 JSON 문자열 리스트로 변환
    final favoriteMoviesJson =
        newList.map((movie) => jsonEncode(movie.toJson())).toList();

    // 변환된 리스트를 SharedPreferences에 저장
    await prefs.setStringList(_favoritesKey, favoriteMoviesJson);
  }
}
