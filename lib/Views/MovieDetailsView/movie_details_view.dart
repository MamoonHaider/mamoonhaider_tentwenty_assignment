import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movies_flutter_app/Models/movie_model.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/app_routes_constants.dart';
import 'package:the_movies_flutter_app/Utilitles/app_theme.dart';
import 'package:the_movies_flutter_app/Views/MovieDetailsView/movie_details_view_providers.dart';
import '../../Utilitles/Constants/app_constants.dart';
import '../../Utilitles/HelperFunctions/helper_functions.dart';
import '../../Utilitles/SharedWidgets/custom_filled_text_button.dart';
import 'movie_details_view_widgets.dart';

class MovieDetailsView extends ConsumerWidget {
  const MovieDetailsView({super.key, this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(MovieDetailsViewProviders.movieDetailsProvider(movie?.id ?? 0));
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: movieDetails.when(
        data: (movieDetail) {
          if (!isLandscape) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  expandedHeight: AppTheme.screenHeightPercentage(context) / 1.8,
                  backgroundColor: AppTheme.transparentColor,
                  leading: IconButton(
                    onPressed: () {
                      if (context.canPop()) context.pop();
                    },
                    icon: Icon(Icons.arrow_back_ios, color: AppTheme.whiteColor),
                  ),
                  title: Text(
                    AppConstants.watchText,
                    style: AppTheme.mediumTextStyle(fontWeight: FontWeight.w500, textColor: AppTheme.whiteColor),
                  ),
                  titleSpacing: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${AppConstants.imageBaseUrl}${movieDetail.posterPath}',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              colors: [AppTheme.blackColor.withAlpha(50), AppTheme.transparentColor],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [AppTheme.blackColor, AppTheme.transparentColor],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                Text(
                                  '${AppConstants.inTheatersText} ${HelperFunctions.formatDateToMonthName(movieDetail.releaseDate)}',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.mediumTextStyleBold(textColor: AppTheme.whiteColor),
                                ),
                                AppTheme.verticalSpaceRegular,
                                CustomFilledTextButton(
                                  onPressed: () {
                                    context.push(AppRoutesConstants.allHallsViewRoute, extra: movie);
                                  },
                                  buttonText: AppConstants.getTicketsText,
                                  fontSize: 14,
                                  borderColor: AppTheme.skyBlueColor,
                                  borderThickness: 2,
                                  backgroundColor: AppTheme.skyBlueColor,
                                ),
                                AppTheme.verticalSpaceSmall,
                                CustomFilledTextButton(
                                  onPressed: () {
                                    context.push(AppRoutesConstants.videoPlayerViewRoute, extra: movieDetail.id);
                                  },
                                  buttonText: AppConstants.watchTrailerText,
                                  icon: Icon(Icons.play_arrow, color: AppTheme.whiteColor),
                                  fontSize: 14,
                                  backgroundColor: AppTheme.transparentColor,
                                  borderColor: AppTheme.skyBlueColor,
                                  borderThickness: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    AppTheme.verticalSpaceMedium,
                    Padding(
                      padding: AppTheme.screenPadding,
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            AppConstants.genresText,
                            style: AppTheme.mediumTextStyleBold(textColor: AppTheme.darkBlueTextColor),
                          ),
                          Wrap(
                            spacing: 4,
                            runSpacing: 0,
                            children: List.generate(movieDetail.genres.length, (index) {
                              return GenreChip(
                                label: movieDetail.genres[index].name,
                                color: GenreColors.getColor(movieDetail.genres[index].name),
                              );
                            }),
                          ),
                          AppTheme.verticalSpaceSmall,
                          Divider(color: AppTheme.lightGreyColor),
                          AppTheme.verticalSpaceSmall,
                          // Overview
                          Text(
                            AppConstants.overviewText,
                            style: AppTheme.mediumTextStyleBold(textColor: AppTheme.darkBlueTextColor),
                          ),
                          AppTheme.verticalSpaceSmall,
                          Text(
                            movieDetail.overview,
                            style: AppTheme.smallTextStyle(textColor: AppTheme.lightGreyTextColor),
                          ),
                          AppTheme.verticalSpaceSmall,
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: '${AppConstants.imageBaseUrl}${movieDetail.posterPath}',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppTheme.blackColor.withAlpha(100), AppTheme.transparentColor],
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [AppTheme.blackColor.withAlpha(150), AppTheme.transparentColor],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 20,
                        right: 20,
                        child: Column(
                          mainAxisSize: .min,
                          children: [
                            Text(
                              '${AppConstants.inTheatersText} ${HelperFunctions.formatDateToMonthName(movieDetail.releaseDate)}',
                              textAlign: TextAlign.center,
                              style: AppTheme.mediumTextStyleBold(textColor: AppTheme.whiteColor),
                            ),
                            AppTheme.verticalSpaceRegular,
                            Row(
                              children: [
                                Expanded(
                                  child: CustomFilledTextButton(
                                    onPressed: () {
                                      context.push(AppRoutesConstants.allHallsViewRoute, extra: movie);
                                    },
                                    buttonText: AppConstants.getTicketsText,
                                    fontSize: 14,
                                    borderColor: AppTheme.skyBlueColor,
                                    borderThickness: 2,
                                    backgroundColor: AppTheme.skyBlueColor,
                                  ),
                                ),
                                AppTheme.horizontalSpaceSmall, // horizontal spacing
                                Expanded(
                                  child: CustomFilledTextButton(
                                    onPressed: () {
                                      context.push(AppRoutesConstants.videoPlayerViewRoute, extra: movieDetail.id);
                                    },
                                    buttonText: AppConstants.watchTrailerText,
                                    icon: Icon(Icons.play_arrow, color: AppTheme.whiteColor),
                                    fontSize: 14,
                                    backgroundColor: AppTheme.transparentColor,
                                    borderColor: AppTheme.skyBlueColor,
                                    borderThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 10,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (context.canPop()) context.pop();
                              },
                              icon: Icon(Icons.arrow_back_ios, color: AppTheme.whiteColor),
                            ),
                            Text(
                              AppConstants.watchText,
                              style: AppTheme.mediumTextStyle(
                                fontWeight: FontWeight.w500,
                                textColor: AppTheme.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: AppTheme.screenPadding,
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        // Genres
                        Text(
                          AppConstants.genresText,
                          style: AppTheme.mediumTextStyleBold(textColor: AppTheme.darkBlueTextColor),
                        ),
                        AppTheme.verticalSpaceSmall,
                        Wrap(
                          spacing: 4,
                          runSpacing: 0,
                          children: List.generate(movieDetail.genres.length, (index) {
                            return GenreChip(
                              label: movieDetail.genres[index].name,
                              color: GenreColors.getColor(movieDetail.genres[index].name),
                            );
                          }),
                        ),
                        AppTheme.verticalSpaceSmall,
                        Divider(color: AppTheme.lightGreyColor),
                        AppTheme.verticalSpaceSmall,
                        // Overview
                        Text(
                          AppConstants.overviewText,
                          style: AppTheme.mediumTextStyleBold(textColor: AppTheme.darkBlueTextColor),
                        ),
                        AppTheme.verticalSpaceSmall,
                        Text(
                          movieDetail.overview,
                          style: AppTheme.smallTextStyle(textColor: AppTheme.lightGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
        loading: () => MovieDetailsShimmer(), // Show shimmer
        error: (error, stacktrace) => Center(
          child: Text(
            AppConstants.somethingWentWrongText,
            style: AppTheme.largeTextStyle(textColor: AppTheme.blackColor),
          ),
        ),
      ),
    );
  }
}
