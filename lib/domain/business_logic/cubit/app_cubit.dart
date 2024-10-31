import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final List<Widget> screens = const [
    MainScreen(),
    MoviesListScreen(),
    SearchScreen(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    emit(BottomNavCurrentItemChange());
  }
}
