// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../common/source.dart';

class MovieDetails {
  int id;
  String backdropPath;
  List<String> genres;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;
  String youtubeTrailer;
  List<Source> sources;
  MovieDetails({
    required this.id,
    required this.backdropPath,
    required this.genres,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.youtubeTrailer,
    required this.sources,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        id: json["_id"],
        backdropPath: json["backdrop_path"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        youtubeTrailer: json["youtube_trailer"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
    );
}
