// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'movie_in_home.dart';

class HomeResponse {
  String title;
  List<MovieInHome> movies;
  HomeResponse({
    required this.title,
    required this.movies,
  });
}
