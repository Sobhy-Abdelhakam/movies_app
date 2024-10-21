import 'package:flutter/material.dart';
import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/models/movies_list/movies_response.dart';
import 'package:movies_app/domain/usecases/get_movies_usecase.dart';

class MoviesListScreen extends StatefulWidget {

  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final GetMoviesUsecase getMoviesUsecase =
      GetMoviesUsecase(RepositoryImpl(ApiClient()));
  Future<MoviesResponse>? movies;

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
        future: movies,
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
              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(4),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: GridTile(
                  footer: Container(
                    color: Colors.black38,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: Text(
                      movie.originalTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loading) {
                      if (loading == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loading.expectedTotalBytes != null
                              ? loading.cumulativeBytesLoaded /
                                  loading.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, exception, stacktrace) {
                      return const Center(child: Text('🥲'));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}