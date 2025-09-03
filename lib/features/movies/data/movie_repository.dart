import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/providers/dio_provider.dart';
import '../domain/movie.dart';

// MovieRepository를 생성하는 Provider
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  // dioProvider를 읽어와서 MovieRepository 생성자에 주입
  return MovieRepository(dio: ref.watch(dioProvider));
});

class MovieRepository {
  final Dio dio;

  MovieRepository({required this.dio});

  // 인기 영화 목록을 가져오는 메서드 (OMDb API는 'popular'를 직접 지원하지 않으므로, 특정 검색어로 대체)
  Future<List<Movie>> fetchMovies(String searchTerm) async {
    // .env에서 불러오기
    final apiKey = dotenv.env[
        'OMDB_API_KEY']; // 테스트를 원할 시 OMDbAPI 사이트에서 API 키를 발급받아 .env 파일에 넣어주세요.

    if (apiKey == null) {
      throw Exception('OMDB_API_KEY not found in .env file');
    }

    final response = await dio.get(
      '/',
      queryParameters: {
        's': searchTerm,
        'apikey': apiKey,
      },
    );

    if (response.statusCode == 200 && response.data['Response'] == 'True') {
      final results = response.data['Search'] as List;
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies: ${response.data['Error']}');
    }
  }
}
