import 'package:the_movies_flutter_app/Models/movie_details_model.dart';
import 'package:the_movies_flutter_app/Models/movie_model.dart';

class WatchModel {
  WatchModel();

  WatchModel.copy(WatchModel state) {
    isSearchBarExpanded = state.isSearchBarExpanded;
    movies = state.movies;
    genres = state.genres;
    currentPage = state.currentPage;
    totalPages = state.totalPages;
    isLoadingMore = state.isLoadingMore;
    hasError = state.hasError;
    searchQuery = state.searchQuery;
    isSearching = state.isSearching;
    isSearchSubmitted = state.isSearchSubmitted;
    totalMovies = state.totalMovies;
  }

  bool isSearchBarExpanded = false;
  bool isScreenLoading = true;
  bool isLoadingMore = false;
  bool hasError = false;
  bool isSearching = false;
  bool isSearchSubmitted = false;
  String searchQuery = '';
  int currentPage = 1;
  int totalPages = 1;
  int? totalMovies = 0;
  List<Movie> movies = [];
  List<Genre> genres = [];
}
