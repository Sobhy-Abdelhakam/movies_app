import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/presentation/widgets/movie_item_Design.dart';

import 'details_screen.dart';

class MainScreen extends StatefulWidget {
  final Future<List<HomeResponse>>? homeData;
  const MainScreen({super.key, required this.homeData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.homeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final homeList = snapshot.data!;
          return ListView.builder(
            itemCount: homeList.length,
            itemBuilder: (context, index) {
              var mainResponseItem = homeList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainResponseItem.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height:
                        200, // Provide a fixed height for the horizontal list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mainResponseItem.movies.length,
                      itemBuilder: (context, index) {
                        var movie = mainResponseItem.movies[index];
                        return SizedBox(
                          width: 120,
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
        });
  }
}
