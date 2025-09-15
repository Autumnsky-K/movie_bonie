import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';
part 'movie_detail.g.dart';

@freezed
class MovieDetail with _$MovieDetail {
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
    required String imdbRating,
    required String imdbID,
    @JsonKey(name: 'Type') required String type,
  }) = _MovieDetail;

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  // final String title;
  // final String year;
  // final String rated;
  // final String released;
  // final String runtime;
  // final String genre;
  // final String director;
  // final String writer;
  // final String actors;
  // final String plot;
  // final String language;
  // final String country;
  // final String awards;
  // final String poster;
  // final String imdbRating;
  // final String imdbID;
  // final String type;

  // MovieDetail({
  //   required this.title,
  //   required this.year,
  //   required this.rated,
  //   required this.released,
  //   required this.runtime,
  //   required this.genre,
  //   required this.director,
  //   required this.writer,
  //   required this.actors,
  //   required this.plot,
  //   required this.language,
  //   required this.country,
  //   required this.awards,
  //   required this.poster,
  //   required this.imdbRating,
  //   required this.imdbID,
  //   required this.type,
  // });

  // factory MovieDetail.fromJson(Map<String, dynamic> json) {
  //   return MovieDetail(
  //     title: json['Title'] ?? 'N/A',
  //     year: json['Year'] ?? 'N/A',
  //     rated: json['Rated'] ?? 'N/A',
  //     released: json['Released'] ?? 'N/A',
  //     runtime: json['Runtime'] ?? 'N/A',
  //     genre: json['Genre'] ?? 'N/A',
  //     director: json['Director'] ?? 'N/A',
  //     writer: json['Writer'] ?? 'N/A',
  //     actors: json['Actors'] ?? 'N/A',
  //     plot: json['Plot'] ?? 'N/A',
  //     language: json['Language'] ?? 'N/A',
  //     country: json['Country'] ?? 'N/A',
  //     awards: json['Awards'] ?? 'N/A',
  //     poster: json['Poster'] ?? 'N/A',
  //     imdbRating: json['imdbRating'] ?? 'N/A',
  //     imdbID: json['imdbID'] ?? 'N/A',
  //     type: json['Type'] ?? 'N/A',
  //   );
  // }
}
