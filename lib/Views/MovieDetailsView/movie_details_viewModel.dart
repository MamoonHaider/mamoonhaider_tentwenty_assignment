import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/MovieDetailsView/movie_details_model.dart';

import '../../Models/movie_video_response_model.dart';
import '../../Services/dio_client_service.dart';

class MovieDetailsViewModel extends StateNotifier<MovieDetailsModel> {
  MovieDetailsViewModel() : super(MovieDetailsModel());
  final dioClient = DioClient();

  Future<void> loadMovieVideos(int movieId) async {
    final res = await dioClient.getMovieVideos(movieId);

    final trailerKey = _getTrailerKey(res.results);

    state = MovieDetailsModel.copy(state)..trailerKey = trailerKey;
  }

  String? _getTrailerKey(List<MovieVideo> videos) {
    for (final v in videos) {
      if (v.site == 'YouTube' && v.type == 'Trailer' && v.official) {
        return v.key;
      }
    }

    for (final v in videos) {
      if (v.site == 'YouTube') {
        return v.key;
      }
    }

    return null;
  }
}
