class VideoPlayerModel {
  VideoPlayerModel();

  VideoPlayerModel.copy(VideoPlayerModel state) {
    isLoading = state.isLoading;
    hasError = state.hasError;
    trailerYoutubeKey = state.trailerYoutubeKey;
  }

  bool isLoading = true;
  bool hasError = false;
  String? trailerYoutubeKey;
}
