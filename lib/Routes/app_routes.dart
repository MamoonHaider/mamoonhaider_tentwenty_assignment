import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movies_flutter_app/Views/AllHallsView/all_halls_view.dart';
import 'package:the_movies_flutter_app/Views/HallView/hall_view.dart';
import 'package:the_movies_flutter_app/Views/HomeView/home_view.dart';
import 'package:the_movies_flutter_app/Views/MovieDetailsView/movie_details_view.dart';
import 'package:the_movies_flutter_app/Views/VideoPlayerView/video_player_view.dart';
import '../Models/movie_model.dart';
import '../Utilitles/Constants/app_routes_constants.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.homeViewRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.homeViewRoute,
        name: AppRoutesConstants.homeViewRouteName,
        pageBuilder: (context, state) => fadeMergeTransition(state, const HomeView()),
      ),
      GoRoute(
        path: AppRoutesConstants.movieDetailsViewRoute,
        name: AppRoutesConstants.movieDetailsViewRouteName,
        pageBuilder: (context, state) {
          final movie = state.extra as Movie?;

          return fadeMergeTransition(state, MovieDetailsView(movie: movie));
        },
      ),
      GoRoute(
        path: AppRoutesConstants.videoPlayerViewRoute,
        name: AppRoutesConstants.videoPlayerViewRouteName,
        pageBuilder: (context, state) {
          final movieId = state.extra as int?;

          return fadeMergeTransition(state, VideoPlayerView(movieId: movieId));
        },
      ),
      GoRoute(
        path: AppRoutesConstants.allHallsViewRoute,
        name: AppRoutesConstants.allHallsViewRouteName,
        pageBuilder: (context, state) {
          final movie = state.extra as Movie?;

          return fadeMergeTransition(state, AllHallsView(movie: movie));
        },
      ),
      GoRoute(
        path: AppRoutesConstants.hallViewRoute,
        name: AppRoutesConstants.hallViewRoute,
        pageBuilder: (context, state) {
          final movie = state.extra as Movie?;

          return fadeMergeTransition(state, HallView(movie: movie,));
        },
      ),
    ],
  );
}

Page fadeMergeTransition(GoRouterState state, Widget child) {
  if (Platform.isIOS) {
    return CupertinoPage(child: child, key: state.pageKey);
  } else {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 900),
      child: child,
      transitionsBuilder: (context, animation, secondary, child) {
        final curve = CurvedAnimation(parent: animation, curve: Curves.easeInOutCirc);
        return FadeTransition(
          opacity: curve,
          child: Transform.scale(
            scale: 0.98 + 0.02 * curve.value,
            child: Transform.translate(offset: Offset(0, 10 * (1 - curve.value)), child: child),
          ),
        );
      },
    );
  }
}
