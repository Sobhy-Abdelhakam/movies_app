// ignore_for_file: public_member_api_docs, sort_constructors_first

class MovieItem {
  int id;
  String backdropPath;
  List<String> genres;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
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

  factory MovieItem.fromJson(Map<String, dynamic> json) {
    return MovieItem(
      id: json['_id'],
      backdropPath: json['backdrop_path'],
      genres: List<String>.from(json['genres']),
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      contentType: json['contentType'],
    );
  }
}
