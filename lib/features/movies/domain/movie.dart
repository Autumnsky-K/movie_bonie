import 'package:freezed_annotation/freezed_annotation.dart';

// 생성될 파일들을 현재 파일의 일부로 포함
part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    // @JsonKey 어노테이션을 사용하여 JSON 필드 이름과 Dart 필드 이름을 매핑
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Year') required String year,
    required String imdbID,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'Poster') required String poster,
  }) = _Movie;

  // json_serializable이 코드를 생성할 수 있도록 fromJson 팩토리 생성자 정의
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  // final String title;
  // final String year;
  // final String imdbID;
  // final String type;
  // final String poster;

  // Movie({
  //   required this.title,
  //   required this.year,
  //   required this.imdbID,
  //   required this.type,
  //   required this.poster,
  // });

  // // JSON을 Movie 객체로 변환하는 팩토리 생성자
  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   return Movie(
  //     title: json['Title'],
  //     year: json['Year'],
  //     imdbID: json['imdbID'],
  //     type: json['Type'],
  //     poster: json['Poster'],
  //   );
  // }

  // // Movie 객체를 JSON으로 변환하는 메서드
  // Map<String, dynamic> toJson() {
  //   return {
  //     'Title': title,
  //     'Year': year,
  //     'imdbID': imdbID,
  //     'Type': type,
  //     'Poster': poster,
  //   };
  // }
}
