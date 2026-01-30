
class MovieDetailsModel {
  MovieDetailsModel();
  MovieDetailsModel.copy(MovieDetailsModel state){
    trailerKey=state.trailerKey;
  }

 String? trailerKey;
}