// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'movie_details.dart';
import 'similar_movies.dart';

class MovieResponse {
  MovieDetails movie;
  List<SimilarMovies> similarMovies;
  MovieResponse({
    required this.movie,
    required this.similarMovies,
  });
}
