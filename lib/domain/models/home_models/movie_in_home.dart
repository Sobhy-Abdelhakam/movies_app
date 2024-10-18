// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../genre.dart';

class MovieInHome {
  int id;
  String backdropPath;
  List<Genre> genres;
  String originalTitle;
  String overview;
  String posterPath;
  DateTime? releaseDate;
  String title;
  String contentType;
  DateTime? firstAired;
  MovieInHome({
    required this.id,
    required this.backdropPath,
    required this.genres,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    required this.contentType,
    this.firstAired,
  });

}
