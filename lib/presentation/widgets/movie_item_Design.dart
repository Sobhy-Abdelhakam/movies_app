import 'package:flutter/material.dart';

class MovieItemDesign extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  const MovieItemDesign({super.key, required this.movieTitle, required this.moviePoster});

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
        child: Image.network(
          moviePoster,
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
  }
}
