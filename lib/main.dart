import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_theme.dart';
import 'package:movies_app/core/utils/my_bloc_observer.dart';
import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/business_logic/cubit/app_cubit.dart';
import 'package:movies_app/domain/business_logic/cubit/main_screen_cubit.dart';
import 'package:movies_app/domain/business_logic/cubit/movies_list_cubit.dart';
import 'package:movies_app/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/domain/usecases/home_usecase.dart';
import 'package:movies_app/presentation/screens/main_app.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryImpl(ApiClient());
    return MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_)=> AppCubit(repository)),
            BlocProvider(create: (_)=> MainScreenCubit(HomeUsecase(repository))..getHomeData()),
            BlocProvider(create: (_)=> MoviesListCubit(GetMoviesUsecase(repository))..getMoviesListData()),
          ],
          child: const MainApp(),
        ));
  }
}
