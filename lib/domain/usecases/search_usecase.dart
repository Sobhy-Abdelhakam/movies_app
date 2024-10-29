import 'package:movies_app/domain/models/search/movie_in_search.dart';
import 'package:movies_app/domain/repository/repository.dart';

class SearchUsecase {
  final Repository repository;
  SearchUsecase(this.repository);

  Future<List<MovieInSearch>> call(String query) => repository.searchMovie(query);
}