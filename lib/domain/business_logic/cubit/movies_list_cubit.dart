import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/usecases/get_movies_usecase.dart';

import 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  final GetMoviesUsecase _getMoviesUsecase;

  MoviesListCubit(this._getMoviesUsecase) : super(MoviesListInitial());

  void getMoviesListData() {
    emit(MoviesListLoading());
    _getMoviesUsecase.call().then((moviesResponse) {
      if (moviesResponse.movies.isEmpty) {
        emit(MoviesListError('No movies available'));
      } else {
        emit(MoviesListLoaded(moviesResponse));
      }
    }).catchError((error) {
      emit(MoviesListError(error.toString()));
    });
  }
}
