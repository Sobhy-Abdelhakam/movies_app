import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/domain/business_logic/cubit/main_screen_cubit.dart';
import 'package:movies_app/domain/business_logic/cubit/main_screen_state.dart';
import 'package:movies_app/presentation/widgets/movie_item_Design.dart';

import 'details_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        // AppCubit cubit = AppCubit.get(context);
        if (state is MainScreenLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MainScreenError) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is MainScreenLoaded) {
          final homeList = state.homeData;
          return ListView.builder(
            itemCount: homeList.length,
            itemBuilder: (context, index) {
              var mainResponseItem = homeList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mainResponseItem.title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height:
                        200.w, // Provide a fixed height for the horizontal list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mainResponseItem.movies.length,
                      itemBuilder: (context, index) {
                        var movie = mainResponseItem.movies[index];
                        return SizedBox(
                          width: 120.w,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(movieId: movie.id),
                                ),
                              );
                            },
                            child: MovieItemDesign(
                              movieTitle: movie.originalTitle,
                              moviePoster: movie.posterPath,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
