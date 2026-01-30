import 'package:flutter_riverpod/legacy.dart';
import '../../Models/movie_video_response_model.dart';
import '../../Services/dio_client_service.dart';
import 'video_player_model.dart';

class VideoPlayerViewModel extends StateNotifier<VideoPlayerModel> {
  VideoPlayerViewModel(int movieId) : super(VideoPlayerModel()) {
    loadTrailer(movieId);
  }

  final dioClient = DioClient();

  Future<void> loadTrailer(int movieId) async {
    state = VideoPlayerModel.copy(state)..isLoading = true;

    try {
      final response = await dioClient.getMovieVideos(movieId);
      final trailerYoutubeKey = getTrailerKey(response.results);

      state = VideoPlayerModel.copy(state)
        ..trailerYoutubeKey = trailerYoutubeKey
        ..isLoading = false;
    } catch (_) {
      state = VideoPlayerModel.copy(state)
        ..isLoading = false
        ..hasError = true;
    }
  }

  String? getTrailerKey(List<MovieVideo> videos) {
    for (final v in videos) {
      if (v.site == 'YouTube' && v.type == 'Trailer' && v.official) {
        return v.key;
      }
    }

    for (final v in videos) {
      if (v.site == 'YouTube' && v.type == 'Trailer') {
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
