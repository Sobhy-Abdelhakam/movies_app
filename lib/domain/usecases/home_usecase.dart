import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/domain/repository/repository.dart';

class HomeUsecase {
  final Repository repository;
  HomeUsecase(this.repository);

  Future<List<HomeResponse>> call() {
    return repository.getCategoriesAndMovies();
  }
}