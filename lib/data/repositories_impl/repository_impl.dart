import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/domain/models/movie_details/Movie_response.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/models/search/movie_in_search.dart';
import 'package:movies_app/domain/models/search/search_response.dart';
import 'package:movies_app/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final ApiClient _apiClient;
  RepositoryImpl(this._apiClient);

  @override
  Future<List<HomeResponse>> getCategoriesAndMovies() async {
    final response = await _apiClient.getHome();
    return response.data!.map((home) => HomeResponse.fromJson(home)).toList();
  }

  @override
  Future<MovieResponse> getMovieDetails(int id) async{
    final response = await _apiClient.getMovieDetails(id);
    return MovieResponse.fromJson(response.data);
  }

  @override
  Future<MoviesResponse> getMovies() async{
    final response = await _apiClient.getMovies();
    return MoviesResponse.fromJson(response.data);
  }

  @override
  Future<List<MovieInSearch>> searchMovie(String query) async {
    final searchResponse = await _apiClient.getSearchResponse(query);
    return SearchResponse.fromJson(searchResponse.data).contents;
  }

}