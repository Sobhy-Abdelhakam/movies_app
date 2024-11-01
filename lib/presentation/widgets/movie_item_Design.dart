import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieItemDesign extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  const MovieItemDesign(
      {super.key, required this.movieTitle, required this.moviePoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: GridTile(
        footer: Container(
          color: Colors.black38,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: Text(
            movieTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: moviePoster,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
          memCacheWidth: 336,
          memCacheHeight: 616,
        ),
      ),
    );
  }
}
