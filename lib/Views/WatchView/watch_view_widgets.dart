import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/app_constants.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/app_routes_constants.dart';
import 'package:the_movies_flutter_app/Utilitles/SharedWidgets/loading_overlay.dart';
import 'package:the_movies_flutter_app/Views/WatchView/watch_view_providers.dart';
import '../../Models/movie_model.dart';
import '../../Utilitles/app_theme.dart';

class MovieContainer extends StatelessWidget {
  const MovieContainer({super.key, this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutesConstants.movieDetailsViewRoute, extra: movie);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: (movie?.posterPath == null || movie!.posterPath!.isEmpty)
                ? Container(
                    width: double.infinity,
                    height: 180,
                    color: AppTheme.lightGreyColor,
                    child: const Icon(Icons.broken_image, color: AppTheme.greyTextColor),
                  )
                : CachedNetworkImage(
                    imageUrl: '${AppConstants.imageBaseUrl}${movie!.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                    placeholder: (context, url) => CustomAppLoader(),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: 180,
                      color: AppTheme.lightGreyColor,
                      child: const Icon(Icons.broken_image, color: AppTheme.greyTextColor),
                    ),
                    fadeInDuration: const Duration(milliseconds: 300),
                    fadeOutDuration: const Duration(milliseconds: 300),
                  ),
          ),

          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [AppTheme.blackColor.withAlpha(100), AppTheme.transparentColor],
              ),
            ),
          ),

          Positioned(
            left: 20,
            bottom: 20,
            right: 20,

            child: Text(
              movie?.title ?? '',
              style: AppTheme.mediumLargeTextStyle(textColor: AppTheme.whiteColor, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableSearchBar extends StatelessWidget {
  const ExpandableSearchBar({
    super.key,
    required this.isExpanded,
    required this.controller,
    required this.toggleExpansion,
    required this.onChanged,
    required this.onSubmitted,
  });

  final bool isExpanded;
  final TextEditingController controller;
  final VoidCallback toggleExpansion;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 48,
      decoration: BoxDecoration(color: AppTheme.whiteColor, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                fillColor: AppTheme.textFieldBgColor,
                filled: true,
                hintText: AppConstants.searchHintText,
                hintStyle: AppTheme.mediumTextStyle(textColor: AppTheme.hintTextColor),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                    toggleExpansion();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchedMovieContainer extends StatelessWidget {
  const SearchedMovieContainer({super.key, this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutesConstants.movieDetailsViewRoute, extra: movie);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.greyTextColor,
          image: DecorationImage(
            image: CachedNetworkImageProvider('${AppConstants.imageBaseUrl}${movie?.posterPath}'),
            fit: BoxFit.cover,

            colorFilter: ColorFilter.mode(AppTheme.blackColor.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          movie?.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.mediumTextStyle(textColor: AppTheme.whiteColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class SearchedMovieTile extends StatelessWidget {
  const SearchedMovieTile({super.key, this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutesConstants.movieDetailsViewRoute, extra: movie);
      },
      child: Row(
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.greyTextColor,
              image: DecorationImage(
                image: CachedNetworkImageProvider('${AppConstants.imageBaseUrl}${movie?.posterPath}'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(10),

            child: movie?.posterPath != null && movie!.posterPath!.isNotEmpty
                ? null
                : Center(child: Icon(Icons.broken_image, color: AppTheme.whiteColor)),
          ),

          AppTheme.horizontalSpaceSmall,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie?.title ?? '',

                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTheme.mediumTextStyleBold(textColor: AppTheme.blackColor),
                ),
                Consumer(
                  builder: (context, genreRef, _) {
                    final genreNames = genreRef
                        .read(WatchViewProviders.watchViewProviders.notifier)
                        .getGenreNames(movie?.genreIds ?? []);

                    final firstGenre = genreNames.isNotEmpty ? genreNames[0] : '';

                    return Text(firstGenre, style: AppTheme.mediumTextStyleBold(textColor: AppTheme.lightGreyColor));
                  },
                ),
              ],
            ),
          ),
          AppTheme.horizontalSpaceSmall,
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz), color: AppTheme.skyBlueColor),
        ],
      ),
    );
  }
}
