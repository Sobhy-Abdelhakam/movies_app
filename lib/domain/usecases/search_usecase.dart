import 'package:movies_app/domain/models/search/search_response.dart';
import 'package:movies_app/domain/repository/repository.dart';

class SearchUsecase {
  final Repository repository;
  SearchUsecase(this.repository);

  Future<SearchResponse> call(String query) => repository.searchMovie(query);
}