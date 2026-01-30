import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/VideoPlayerView/video_player_model.dart';
import 'package:the_movies_flutter_app/Views/VideoPlayerView/video_player_viewModel.dart';

class VideoPlayerViewProviders {
  static final videoPlayerViewProviders = StateNotifierProvider.autoDispose
      .family<VideoPlayerViewModel, VideoPlayerModel, int>((ref, movieId) {
        return VideoPlayerViewModel(movieId);
      });
}
