// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../common/source.dart';

class MovieInSearch {
  int id;
  String backdropPath;
  List<String> genres;
  String originalTitle;
  String overview;
  String posterPath;
  DateTime? releaseDate;
  String title;
  double voteAverage;
  int voteCount;
  String youtubeTrailer;
  List<Source> sources;
  String contentType;
  DateTime? firstAired;
  MovieInSearch({
    required this.id,
    required this.backdropPath,
    required this.genres,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.youtubeTrailer,
    required this.sources,
    required this.contentType,
    this.firstAired,
  });

  factory MovieInSearch.fromJson(Map<String, dynamic> json) => MovieInSearch(
        id: json["_id"],
        backdropPath: json["backdrop_path"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        youtubeTrailer: json["youtube_trailer"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        contentType: json["contentType"],
        firstAired: json["first_aired"] == null ? null : DateTime.parse(json["first_aired"]),
    );
}
