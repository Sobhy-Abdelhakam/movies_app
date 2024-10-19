import 'package:flutter/material.dart';
import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/repository/repository.dart';
import 'package:movies_app/domain/usecases/get_movies_usecase.dart';

void main() async {
  final GetMoviesUsecase getMoviesUsecase =
      GetMoviesUsecase(RepositoryImpl(ApiClient()));
  var movies = getMoviesUsecase.call();
  debugPrint('in screen: $movies');
  runApp(MyApp(
    movies: movies,
  ));
}

class MyApp extends StatelessWidget {
  final Future<MoviesResponse> movies;
  const MyApp({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        movies: movies,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.movies});
  final String title;
  final Future<MoviesResponse> movies;

  // var movies = [];
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: widget.movies,
            builder: (context, snapshot) {
              final moviesList = snapshot.data?.movies ?? [];
              return ListView.builder(
                itemCount: moviesList.length,
                itemBuilder: (context, index) {
                  return Text(moviesList[index].title);
                },
              );
            }));
  }
}
