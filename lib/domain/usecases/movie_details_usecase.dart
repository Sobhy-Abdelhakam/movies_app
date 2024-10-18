import 'package:movies_app/domain/models/movie_details/Movie_response.dart';
import 'package:movies_app/domain/repository/repository.dart';

class MovieDetailsUsecase {
  final Repository repository;
  MovieDetailsUsecase(this.repository);

  Future<MovieResponse> call(int id) => repository.getMovieDetails(id);
}