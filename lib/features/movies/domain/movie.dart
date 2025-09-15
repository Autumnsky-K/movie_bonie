import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
abstract class Movie with _$Movie {
  const factory Movie({
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Year') required String year,
    required String imdbID,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'Poster') required String poster,
  }) = _Movie;

  factory Movie.fromJson(Map<String, Object?> json) => _$MovieFromJson(json);
}
