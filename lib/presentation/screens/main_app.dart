import 'package:flutter/material.dart';
import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/domain/usecases/home_usecase.dart';
import 'package:movies_app/presentation/screens/movies_list_screen.dart';
import 'package:movies_app/presentation/screens/search_screen.dart';
import 'package:movies_app/presentation/screens/main_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GetMoviesUsecase getMoviesUsecase =
      GetMoviesUsecase(RepositoryImpl(ApiClient()));
  final HomeUsecase homeUsecase = HomeUsecase(RepositoryImpl(ApiClient()));
  Future<List<HomeResponse>>? homeResponse;
  Future<MoviesResponse>? movies;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    homeResponse = homeUsecase.call();
    movies = getMoviesUsecase.call();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      MainScreen(homeData: homeResponse),
      MoviesListScreen(
        movies: movies,
      ),
      const SearchScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
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
          ),
        ],
      ),
    );
  }
}
