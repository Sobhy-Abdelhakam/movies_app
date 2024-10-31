part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class BottomNavCurrentItemChange extends AppState {}

final class MainScreenLoading extends AppState {}

final class MainScreenLoaded extends AppState {
  // final List<HomeResponse> homeData;
  MainScreenLoaded();
}

final class MainScreenError extends AppState {
  final String error;
  MainScreenError(this.error);
}

final class MoviesListLoading extends AppState {}

final class MoviesListLoaded extends AppState {
  // final MoviesResponse moviesResponse;
  MoviesListLoaded();
}

final class MoviesListError extends AppState {
  final String error;
  MoviesListError(this.error);
}
