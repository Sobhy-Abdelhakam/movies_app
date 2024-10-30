// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movies_app/domain/models/movies_list/movie_item.dart';

import 'movie_details.dart';

class MovieResponse {
  MovieDetails movie;
  List<MovieItem> similarMovies;
  MovieResponse({
    required this.movie,
    required this.similarMovies,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movie: MovieDetails.fromJson(json["movie"]),
        similarMovies: List<MovieItem>.from(json["similarMovies"].map((x) => MovieItem.fromJson(x))),
    );
}
