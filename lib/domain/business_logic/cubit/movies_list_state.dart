import 'package:movies_app/domain/models/movies_list/movies_response.dart';

abstract class MoviesListState {}

class MoviesListInitial extends MoviesListState {}
class MoviesListLoading extends MoviesListState {}
class MoviesListLoaded extends MoviesListState {
  final MoviesResponse moviesResponse;
  MoviesListLoaded(this.moviesResponse);
}
class MoviesListError extends MoviesListState {
  final String error;
  MoviesListError(this.error);
}
