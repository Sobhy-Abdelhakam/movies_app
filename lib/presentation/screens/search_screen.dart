import 'package:flutter/material.dart';
import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/models/search/movie_in_search.dart';
import 'package:movies_app/domain/usecases/search_usecase.dart';
import 'package:movies_app/presentation/widgets/movie_item_Design.dart';

import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  SearchUsecase searchUsecase = SearchUsecase(RepositoryImpl(ApiClient()));
  Future<List<MovieInSearch>>? movies;

  void _onSearchChange(String query) {
    setState(() {
      movies = query.isNotEmpty ? searchUsecase.call(query) : null;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: searchController,
            onChanged: _onSearchChange,
            decoration: InputDecoration(
              hintText: 'Search',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching movies'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No movies found'));
                }

                final moviesList = snapshot.data!;
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
                            builder: (context) =>
                                DetailsScreen(movieId: movie.id),
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
            ),
          )
        ],
      ),
    );
  }
}
