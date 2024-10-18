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
}
