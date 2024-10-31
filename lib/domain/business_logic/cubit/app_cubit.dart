import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/repository/repository.dart';
import 'package:movies_app/presentation/screens/main_screen.dart';
import 'package:movies_app/presentation/screens/movies_list_screen.dart';
import 'package:movies_app/presentation/screens/search_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final Repository repository;
  AppCubit(this.repository) : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.movie_creation_outlined),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    )
  ];
  final List<Widget> screens = const [
    MainScreen(),
    MoviesListScreen(),
    SearchScreen(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    emit(BottomNavCurrentItemChange());
  }

  void initializeData() {
    getHomeData();
    getMoviesListData();
  }

  List<HomeResponse> homeData = [];
  void getHomeData(){
    emit(MainScreenLoading());
    repository.getCategoriesAndMovies().then((value) {
      if (value.isEmpty) {
        emit(MainScreenError('No data available'));
      } else {
        homeData = value;
        emit(MainScreenLoaded());
      }
    }).catchError((error) {
      emit(MainScreenError(error.toString()));
    });
  }

  MoviesResponse? moviesResponse;
  void getMoviesListData() {
    emit(MoviesListLoading());
    repository.getMovies().then((movies) {
      if (movies.movies.isEmpty) {
        emit(MoviesListError('No Movies available'));
      } else {
        moviesResponse = movies;
        emit(MoviesListLoaded());
      }
    }).catchError((error) {
      emit(MoviesListError(error));
    });
  }
}
