import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/repository/repository.dart';

class GetMoviesUsecase {
  final Repository repository;
  GetMoviesUsecase(this.repository);
  
  Future<MoviesResponse> call() {
    return repository.getMovies();
  }
}