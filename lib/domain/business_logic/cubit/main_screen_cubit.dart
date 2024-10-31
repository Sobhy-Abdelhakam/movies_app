import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/usecases/home_usecase.dart';

import 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  final HomeUsecase _homeUsecase;

  MainScreenCubit(this._homeUsecase) : super(MainScreenInitial());

  void getHomeData() {
    emit(MainScreenLoading());
    _homeUsecase.call().then((homeData) {
      if (homeData.isEmpty) {
        emit(MainScreenError('No data available'));
      } else {
        emit(MainScreenLoaded(homeData));
      }
    }).catchError((error) {
      emit(MainScreenError(error.toString()));
    });
  }
}
