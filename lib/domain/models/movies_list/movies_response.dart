// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'movie_item.dart';

class MoviesResponse {
  List<MovieItem> movies;
  int page;
  MoviesResponse({
    required this.movies,
    required this.page,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      movies:
          (json['movies'] as List).map((i) => MovieItem.fromJson(i)).toList(),
      page: json['page'],
    );
  }
}
