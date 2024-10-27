import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/domain/models/movie_details/Movie_response.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/models/search/search_response.dart';
import 'package:movies_app/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final ApiClient _apiClient;
  RepositoryImpl(this._apiClient);

  @override
  Future<List<HomeResponse>> getCategoriesAndMovies() async {
    final response = await _apiClient.getHome();
    return response.data!.map((home) => HomeResponse.fromJson(home)).toList();
    // return HomeResponse.fromJson(response.data);
  }

  @override
  Future<MovieResponse> getMovieDetails(int id) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }

  @override
  Future<MoviesResponse> getMovies() async{
    final response = await _apiClient.getMovies();
    return MoviesResponse.fromJson(response.data);
  }

  @override
  Future<SearchResponse> searchMovie(String query) {
    // TODO: implement searchMovie
    throw UnimplementedError();
  }

}