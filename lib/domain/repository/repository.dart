import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/domain/models/movie_details/Movie_response.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/models/search/search_response.dart';

abstract class Repository {
  Future<List<HomeResponse>> getCategoriesAndMovies();
  Future<MoviesResponse> getMovies();
  Future<MovieResponse> getMovieDetails(int id);
  Future<SearchResponse> searchMovie(String query);
}