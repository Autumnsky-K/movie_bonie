import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';
part 'movie_detail.g.dart';

@freezed
abstract class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Year') required String year,
    @JsonKey(name: 'Rated') required String rated,
    @JsonKey(name: 'Released') required String released,
    @JsonKey(name: 'Runtime') required String runtime,
    @JsonKey(name: 'Genre') required String genre,
    @JsonKey(name: 'Director') required String director,
    @JsonKey(name: 'Writer') required String writer,
    @JsonKey(name: 'Actors') required String actors,
    @JsonKey(name: 'Plot') required String plot,
    @JsonKey(name: 'Language') required String language,
    @JsonKey(name: 'Country') required String country,
    @JsonKey(name: 'Awards') required String awards,
    @JsonKey(name: 'Poster') required String poster,
    @JsonKey(name: 'imdbRating') required String imdbRating,
    required String imdbID,
    @JsonKey(name: 'Type') required String type,
  }) = _MovieDetail;

  factory MovieDetail.fromJson(Map<String, Object?> json) =>
      _$MovieDetailFromJson(json);
}
