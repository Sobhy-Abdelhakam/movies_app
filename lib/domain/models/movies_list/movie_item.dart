// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieItem {
  int id;
  String backdropPath;
  List<String> genres;
  String originalTitle;
  String overview;
  String posterPath;
  DateTime releaseDate;
  String title;
  String contentType;
  MovieItem({
    required this.id,
    required this.backdropPath,
    required this.genres,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.contentType,
  });
}
