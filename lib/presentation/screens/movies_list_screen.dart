// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/business_logic/cubit/app_cubit.dart';
import 'package:movies_app/presentation/screens/details_screen.dart';
import 'package:movies_app/presentation/widgets/movie_item_Design.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if (state is MoviesListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesListError) {
          return Center(
            child: Text(state.error),
          );
        }
        final moviesList = cubit.moviesResponse!.movies;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
          itemCount: moviesList.length,
          itemBuilder: (context, index) {
            final movie = moviesList[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movieId: movie.id),
                  ),
                );
              },
              child: MovieItemDesign(
                movieTitle: movie.originalTitle,
                moviePoster: movie.posterPath,
              ),
            );
          },
        );
      },
    );
  }
}
