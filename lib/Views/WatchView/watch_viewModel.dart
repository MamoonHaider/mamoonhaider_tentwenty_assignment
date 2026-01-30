import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/WatchView/watch_model.dart';

import '../../Services/dio_client_service.dart';

class WatchViewModel extends StateNotifier<WatchModel> {
  WatchViewModel() : super(WatchModel()) {
    scrollController.addListener(onScroll);
    loadMovies();
    loadGenres();
  }

  final dioClient = DioClient();
  Timer? searchDebounce;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  void toggleSearchBarExpansion() {
    state = WatchModel.copy(state)..isSearchBarExpanded = !state.isSearchBarExpanded;
  }

  void toggleIsLoading() {
    state = WatchModel.copy(state)..isScreenLoading = !state.isScreenLoading;
  }

  void toggleIsLoadingMore() {
    state = WatchModel.copy(state)..isLoadingMore = !state.isLoadingMore;
  }

  void onScroll() {
    if (!scrollController.hasClients) return;
    if (state.isScreenLoading || state.isLoadingMore) return;

    final threshold = 200.0;
    final position = scrollController.position;

    if (position.pixels >= position.maxScrollExtent - threshold) {
      loadMovies(loadMore: true);
    }
  }

  bool shouldLoadMore(ScrollMetrics metrics, double threshold) {
    return !state.isLoadingMore &&
        !state.isScreenLoading &&
        metrics.pixels >= metrics.maxScrollExtent - threshold &&
        state.currentPage < state.totalPages;
  }

  Future<void> loadMovies({bool loadMore = false}) async {
    if (loadMore) {
      if (state.currentPage >= state.totalPages || state.isLoadingMore) return;
      toggleIsLoadingMore();
    } else {
      toggleIsLoading();
      state = WatchModel.copy(state)
        ..movies = []
        ..currentPage = 1
        ..totalPages = 1
        ..hasError = false;
    }

    try {
      final pageToLoad = loadMore ? state.currentPage + 1 : 1;

      final response = state.isSearching
          ? await dioClient.searchMovies(query: state.searchQuery, page: pageToLoad)
          : await dioClient.getUpcomingMovies(page: pageToLoad);

      final newMovies = response.results;
      final totalPages = response.totalPages;

      if (loadMore) {
        state = WatchModel.copy(state)
          ..movies = [...state.movies, ...newMovies]
          ..currentPage = pageToLoad
          ..totalPages = totalPages
          ..isLoadingMore = false;
      } else {
        state = WatchModel.copy(state)
          ..movies = newMovies
          ..currentPage = pageToLoad
          ..totalPages = totalPages
          ..isScreenLoading = false;
      }
    } catch (_) {
      if (loadMore) {
        state = WatchModel.copy(state)..isLoadingMore = false;
      } else {
        state = WatchModel.copy(state)
          ..isScreenLoading = false
          ..hasError = true;
      }
    }
  }

  Future<void> refreshMovies() async {
    state = WatchModel.copy(state)
      ..isScreenLoading = true
      ..isLoadingMore = false
      ..currentPage = 1
      ..movies = [];

    try {
      final res = await dioClient.getUpcomingMovies(page: 1);

      state = WatchModel.copy(state)
        ..movies = res.results
        ..currentPage = 1
        ..totalPages = res.totalPages
        ..isScreenLoading = false;
    } catch (_) {
      state = WatchModel.copy(state)..isScreenLoading = false;
    }
  }

  void onSearchChanged(String query) {
    searchDebounce?.cancel();

    searchDebounce = Timer(const Duration(milliseconds: 400), () {
      state = WatchModel.copy(state)
        ..searchQuery = query
        ..isSearchSubmitted = false
        ..isSearching = query.isNotEmpty;

      if (query.isEmpty) {
        loadMovies();
      } else {
        searchMovies(autoSubmit: false);
      }
    });
  }

  void setIsSearchSubmitted(bool val) {
    state = WatchModel.copy(state)..isSearchSubmitted = val;
  }

  Future<void> searchMovies({bool loadMore = false,  bool autoSubmit = true,
  }) async {
    if (state.searchQuery.isEmpty) return;

    if (loadMore) {
      if (state.currentPage >= state.totalPages || state.isLoadingMore) return;
      toggleIsLoadingMore();
    } else {
      state = WatchModel.copy(state)
        ..isScreenLoading = true
        ..movies = []
        ..currentPage = 1
        ..isSearchSubmitted = autoSubmit;
    }

    try {
      final page = loadMore ? state.currentPage + 1 : 1;

      final res = await dioClient.searchMovies(query: state.searchQuery, page: page);

      state = WatchModel.copy(state)
        ..movies = loadMore ? [...state.movies, ...res.results] : res.results
        ..currentPage = page
        ..totalPages = res.totalPages
        ..isScreenLoading = false
        ..isLoadingMore = false
        ..totalMovies = res.totalResults
        ..isSearchSubmitted = autoSubmit;
      // keep search submitted
    } catch (_) {
      state = WatchModel.copy(state)
        ..isScreenLoading = false
        ..isLoadingMore = false
        ..hasError = true
        ..isSearchSubmitted = autoSubmit;
    }
  }

  Future<void> loadGenres() async {
    try {
      final response = await dioClient.getGenres();

      state = WatchModel.copy(state)..genres = response;
    } catch (_) {
      state = WatchModel.copy(state)..hasError = true;
    }
  }

  List<String> getGenreNames(List<int> genreIds) {
    final genreMap = {for (var g in state.genres) g.id: g.name};

    return genreIds.map((id) => genreMap[id] ?? '').toList();
  }
}
