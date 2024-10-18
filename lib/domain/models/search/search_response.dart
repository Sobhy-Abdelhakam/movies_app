// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movies_app/domain/models/search/movie_in_search.dart';

class SearchResponse {
  String query;
  List<MovieInSearch> contents;
  SearchResponse({
    required this.query,
    required this.contents,
  });
}