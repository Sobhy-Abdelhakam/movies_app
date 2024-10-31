import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/api_service/api_client.dart';
import 'package:movies_app/data/repositories_impl/repository_impl.dart';
import 'package:movies_app/domain/models/movie_details/Movie_response.dart';
import 'package:movies_app/domain/usecases/movie_details_usecase.dart';
import 'package:movies_app/presentation/widgets/movie_item_Design.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;
  const DetailsScreen({super.key, required this.movieId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final MovieDetailsUsecase _detailsUsecase =
      MovieDetailsUsecase(RepositoryImpl(ApiClient()));
  Future<MovieResponse>? movie;
  late YoutubePlayerController _youtubeController;
  @override
  void initState() {
    super.initState();
    movie = _detailsUsecase.call(widget.movieId);
    movie?.then(
      (movieResponse) {
        final movieUrl = movieResponse.movie.youtubeTrailer;
        final videoId = YoutubePlayer.convertUrlToId(movieUrl);
        if (videoId != null) {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching movies'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No movies found'));
            }
            final details = snapshot.data!.movie;
            final similar = snapshot.data!.similarMovies;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 500,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        details.originalTitle,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      background: CachedNetworkImage(
                        imageUrl: details.backdropPath,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error_outline),
                        ),
                      )),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '${details.voteAverage} / 10',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(details.releaseDate),
                            ),
                            Wrap(
                              children: [
                                ...details.genres.map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        backgroundColor: Colors.amber,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              details.overview,
                              textAlign: TextAlign.justify,
                            ),
                            const Text(
                              'Youtube trailer',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            YoutubePlayer(
                              controller: _youtubeController,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.amber,
                              progressColors: const ProgressBarColors(
                                playedColor: Colors.amber,
                                handleColor: Colors.amberAccent,
                              ),
                            ),
                            const Text(
                              'Similar Movies',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 3,
                              ),
                              itemCount: similar.length,
                              itemBuilder: (context, index) {
                                final similarItem = similar[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                            movieId: similarItem.id),
                                      ),
                                    );
                                  },
                                  child: MovieItemDesign(
                                    movieTitle: similarItem.originalTitle,
                                    moviePoster: similarItem.posterPath,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
