import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/MovieDetailsView/movie_details_model.dart';
import 'package:the_movies_flutter_app/Views/MovieDetailsView/movie_details_viewModel.dart';

import '../../Models/movie_details_model.dart';
import '../../Services/dio_client_service.dart';

class MovieDetailsViewProviders {
  static var movieDetailsViewProviders = StateNotifierProvider.autoDispose<MovieDetailsViewModel, MovieDetailsModel>(
    (ref) => MovieDetailsViewModel(),
  );

  static final movieDetailsProvider = FutureProvider.family<MovieDetails, int>((ref, movieId) async {
    final dioClient = DioClient();
    final movieDetails = await dioClient.getMovieDetails(movieId);
    return movieDetails;
  });
}
