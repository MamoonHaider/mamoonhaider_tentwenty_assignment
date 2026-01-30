import 'movie_dates_model.dart';
import 'movie_model.dart';

class MoviesResponse {
  final Dates? dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MoviesResponse({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'],
      results: (json['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
