// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../genre.dart';

class MovieInHome {
  int id;
  String backdropPath;
  List<String> genres;
  String originalTitle;
  String overview;
  String posterPath;
  String? releaseDate;
  String title;
  String contentType;
  String? firstAired;
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
  factory MovieInHome.fromJson(Map<String, dynamic> json) {
    return MovieInHome(
        id: json['_id'],
        backdropPath: json['backdrop_path'],
        genres: List<String>.from(json['genres']),
        originalTitle: json['original_title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        contentType: json['contentType'],
        firstAired: json['first_aired']
        );
  }
}
