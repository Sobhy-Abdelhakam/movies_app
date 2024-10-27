import 'package:flutter/material.dart';
import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/models/home_models/home_response.dart';
import 'package:movies_app/domain/usecases/home_usecase.dart';

class MainScreen extends StatefulWidget {
  final Future<List<HomeResponse>>? homeData;
  const MainScreen({super.key, required this.homeData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final HomeUsecase mainUsecase = HomeUsecase(RepositoryImpl(ApiClient()));
  // Future<List<HomeResponse>>? home;
  // @override
  // void initState() {
  //   super.initState();
  //   home = mainUsecase.call();
  // }

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
                        return Container(
                          width: 120, // Set a fixed width for each movie item
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
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
                    ),
                  )
                ],
              );
            },
          );
        });
  }
}
