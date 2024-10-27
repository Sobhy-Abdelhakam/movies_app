// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/presentation/widgets/movie_item_Design.dart';

class MoviesListScreen extends StatefulWidget {
  final Future<MoviesResponse>? movies;
  const MoviesListScreen({
    super.key,
    required this.movies,
  });

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  // final GetMoviesUsecase getMoviesUsecase =
  //     GetMoviesUsecase(RepositoryImpl(ApiClient()));
  // Future<MoviesResponse>? movies;

  @override
  void initState() {
    super.initState();
    // movies = getMoviesUsecase.call();
    debugPrint('init in movies screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.movies,
        builder: (context, snapshot) {
          final moviesList = snapshot.data?.movies ?? [];
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
            itemCount: moviesList.length,
            itemBuilder: (context, index) {
              final movie = moviesList[index];
              return MovieItemDesign(movie: movie);
            },
          );
        },
      ),
    );
  }
}
