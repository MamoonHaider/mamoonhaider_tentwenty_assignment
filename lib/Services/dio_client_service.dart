import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/dio_constants.dart';

import '../Models/movie_details_model.dart';
import '../Models/movie_video_response_model.dart';
import '../Models/movies_response_model.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: DioConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${DioConstants.accessToken}',
        },
      ),
    );

    dio.interceptors.addAll([
      ErrorInterceptor(),
      PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, error: true, compact: true),
    ]);
  }

  Future<MoviesResponse> getUpcomingMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '${DioConstants.movieEp}/${DioConstants.upcomingEp}',
        queryParameters: {'page': page},
      );

      return MoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get('${DioConstants.movieEp}/$movieId');

      return MovieDetails.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<MoviesResponse> searchMovies({required String query, int page = 1}) async {
    try {
      final response = await dio.get(
        DioConstants.searchEp,
        queryParameters: {'query': query, 'page': page, },
      );

      return MoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<List<Genre>> getGenres() async {
    try {
      final response = await dio.get(DioConstants.genresEp);

      final List genresJson = response.data['genres'];
      return genresJson.map((e) => Genre.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch genres: ${e.message}');
    }
  }

  Future<MovieVideosResponse> getMovieVideos(int movieId) async {
    try {
      final response = await dio.get('${DioConstants.movieEp}/$movieId/videos');

      return MovieVideosResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }
}

String _handleDioError(DioException e) {
  if (e.response != null) {
    return 'TMDB Error: ${e.response?.statusCode}';
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';
    case DioExceptionType.receiveTimeout:
      return 'Server timeout';
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      return 'No internet connection';
    default:
      return e.message ?? 'Unexpected error';
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = 'Unexpected error';

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Server took too long to respond';
        break;
      case DioExceptionType.badResponse:
        message = 'TMDB Error: ${err.response?.statusCode}';
        break;
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        message = 'No internet connection';
        break;
      default:
        message = err.message ?? message;
    }

    if (kDebugMode) {
      print('TMDB Dio Error → $message');
    }

    super.onError(err, handler);
  }
}
