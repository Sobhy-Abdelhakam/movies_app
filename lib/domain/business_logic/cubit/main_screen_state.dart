import 'package:movies_app/domain/models/home_models/home_response.dart';

abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}
class MainScreenLoading extends MainScreenState {}
class MainScreenLoaded extends MainScreenState {
  final List<HomeResponse> homeData;
  MainScreenLoaded(this.homeData);
}
class MainScreenError extends MainScreenState {
  final String error;
  MainScreenError(this.error);
}