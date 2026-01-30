class MovieVideosResponse {
  final List<MovieVideo> results;

  MovieVideosResponse({required this.results});

  factory MovieVideosResponse.fromJson(Map<String, dynamic> json) {
    return MovieVideosResponse(
      results: (json['results'] as List)
          .map((e) => MovieVideo.fromJson(e))
          .toList(),
    );
  }
}

class MovieVideo {
  final String key;
  final String site;
  final String type;
  final bool official;

  MovieVideo({
    required this.key,
    required this.site,
    required this.type,
    required this.official,
  });

  factory MovieVideo.fromJson(Map<String, dynamic> json) {
    return MovieVideo(
      key: json['key'],
      site: json['site'],
      type: json['type'],
      official: json['official'] ?? false,
    );
  }
}
