import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/app_constants.dart';
import 'package:the_movies_flutter_app/Utilitles/SharedWidgets/pull_to_refresh_widget.dart';
import 'package:the_movies_flutter_app/Utilitles/app_theme.dart';
import 'package:the_movies_flutter_app/Views/WatchView/watch_view_providers.dart';
import 'package:the_movies_flutter_app/Views/WatchView/watch_view_widgets.dart';
import '../../Utilitles/SharedWidgets/loading_overlay.dart';

class WatchView extends ConsumerWidget {
  const WatchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = WatchViewProviders.watchViewProviders;
    final viewModel = ref.read(WatchViewProviders.watchViewProviders.notifier);
    return Scaffold(
      backgroundColor: AppTheme.offWhiteColor,

      body: SafeArea(
        child: CustomRefreshIndicator(
          topDistance: 100,
          onRefresh: () => viewModel.refreshMovies(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                final metrics = notification.metrics;
                const threshold = 200.0;
                if (viewModel.shouldLoadMore(metrics, threshold)) {
                  viewModel.loadMovies(loadMore: true);
                }
              }
              return false;
            },

            child: CustomScrollView(
              slivers: [
                Consumer(
                  builder: (context, ref, _) {
                    final isSearchBarExpanded = ref.watch(provider.select((model) => model.isSearchBarExpanded));
                    final isSearchSubmitted = ref.watch(provider.select((model) => model.isSearchSubmitted));
                    final totalMovies = ref.watch(provider.select((model) => model.totalMovies));
                    final viewModel = ref.read(WatchViewProviders.watchViewProviders.notifier);

                    return SliverAppBar(
                      toolbarHeight: 70,
                      floating: true,
                      backgroundColor: AppTheme.whiteColor,
                      leading: (isSearchSubmitted)
                          ? IconButton(
                        onPressed: () {
                          viewModel.setIsSearchSubmitted(false);
                        },

                        icon: Icon(Icons.arrow_back_ios, color: AppTheme.blackColor),
                      )
                          : null,
                      titleSpacing: 0,
                      title: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.horizontal,
                              axisAlignment: -1,
                              child: child,
                            ),
                          );
                        },

                        child: isSearchSubmitted
                            ? Text(
                          '${totalMovies} ${AppConstants.resultFoundText} ',
                          key: const ValueKey('title'),
                          style: AppTheme.mediumTextStyleBold(
                            textColor: AppTheme.blackColor,
                            fontFamily: AppTheme.appFontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                            : isSearchBarExpanded
                            ? Padding(
                          padding: AppTheme.screenPadding,
                          key: const ValueKey('searchBar'),

                          child: ExpandableSearchBar(
                            isExpanded: true,
                            controller: viewModel.searchController,
                            toggleExpansion: () => viewModel.toggleSearchBarExpansion(),
                            onChanged: viewModel.onSearchChanged,
                            onSubmitted: (_) {
                              viewModel.searchMovies(autoSubmit: true);
                              viewModel.setIsSearchSubmitted(true);
                            },
                          ),
                        )
                            : Padding(
                          padding: AppTheme.screenPadding,
                          key: const ValueKey('title'),

                          child: Text(
                            AppConstants.watchText,
                            style: AppTheme.mediumTextStyleBold(
                              textColor: AppTheme.blackColor,
                              fontFamily: AppTheme.appFontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      actions: isSearchBarExpanded
                          ? []
                          : [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => viewModel.toggleSearchBarExpansion(),
                        ),
                      ],
                    );
                  },
                ),
                SliverToBoxAdapter(child: AppTheme.verticalSpaceRegular),
                SliverToBoxAdapter(
                  child: Consumer(
                    builder: (context, searchTitleRef, _) {
                      final isSearching = ref.watch(provider.select((model) => model.isSearching));
                      final isSearchSubmitted = ref.watch(provider.select((model) => model.isSearchSubmitted));
                      var movies = ref.watch(WatchViewProviders.watchViewProviders.select((model) => model.movies));

                      return Padding(
                        padding: AppTheme.screenPadding,
                        child: (isSearching && !isSearchSubmitted)
                            ? Column(
                          crossAxisAlignment: .start,
                          children: [
                            (movies.isNotEmpty) ?
                            Text(
                              AppConstants.topResultsText,
                              style: AppTheme.mediumTextStyleBold(
                                textColor: AppTheme.blackColor,
                                fontFamily: AppTheme.appFontFamily,
                                fontWeight: FontWeight.w500,
                              ),
                            ):Text(
                              AppConstants.noResultFound,
                              style: AppTheme.mediumTextStyleBold(
                                textColor: AppTheme.blackColor,
                                fontFamily: AppTheme.appFontFamily,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(color: AppTheme.lightGreyColor),
                          ],
                        )
                            : SizedBox.shrink(
                        )
                        ,
                      );
                    },
                  ),
                ),

                SliverToBoxAdapter(child: AppTheme.verticalSpaceSmall),
                Consumer(
                  builder: (context, ref, _) {
                    final model = ref.watch(WatchViewProviders.watchViewProviders);

                    if (model.movies.isNotEmpty) {
                      return !model.isSearchBarExpanded
                          ? SliverPadding(
                        padding: AppTheme.screenPadding,
                        sliver: SliverList.separated(
                          itemCount: model.movies.length,
                          itemBuilder: (context, index) {
                            return MovieContainer(movie: model.movies[index]);
                          },
                          separatorBuilder: (_, __) => AppTheme.verticalSpaceRegular,
                        ),
                      )
                          : viewModel.searchController.text.isEmpty
                          ? SliverPadding(
                        padding: AppTheme.screenPadding,
                        sliver: SliverGrid.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 100,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: model.movies.length,
                          itemBuilder: (context, index) {
                            return SearchedMovieContainer(movie: model.movies[index]);
                          },
                        ),
                      )
                          : SliverPadding(
                        padding: AppTheme.screenPadding,

                        sliver: SliverList.separated(
                          itemCount: model.movies.length,

                          itemBuilder: (context, index) {
                            return SearchedMovieTile(movie: model.movies[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return AppTheme.verticalSpaceSmall;
                          },
                        ),
                      );
                    } else if (model.isScreenLoading) {
                      return Consumer(
                        builder: (context, shimmerRef, _) {
                          final isSearchBarExpanded = ref.watch(provider.select((model) => model.isSearchBarExpanded));

                          return SliverFillRemaining(
                            hasScrollBody: true,
                            child: Shimmer.fromColors(
                              baseColor: AppTheme.shimmerGrey.withAlpha(150),
                              highlightColor: AppTheme.whiteColor.withAlpha(100),
                              child: Padding(
                                padding: AppTheme.screenPadding,
                                child: !isSearchBarExpanded
                                    ? SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(10, (index) {
                                      return Column(
                                        children: [
                                          MovieContainer(),
                                          if (index < 9) AppTheme.verticalSpaceRegular,
                                        ],
                                      );
                                    }),
                                  ),
                                )
                                    : viewModel.searchController.text.isEmpty
                                    ? GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 100,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    return SearchedMovieContainer();
                                  },
                                )
                                    : ListView.separated(
                                  itemCount: 10,

                                  itemBuilder: (context, index) {
                                    return SearchedMovieTile();
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return AppTheme.verticalSpaceSmall;
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SliverFillRemaining(
                        hasScrollBody: true,
                        child: Center(
                          child: Text(
                            AppConstants.noMoviesFound,
                            style: AppTheme.largeTextStyle(textColor: AppTheme.blackColor),
                          ),
                        ),
                      );
                    }
                  },
                ),

                SliverToBoxAdapter(child: AppTheme.verticalSpaceSmall),

                Consumer(
                  builder: (context, loaderRef, _) {
                    return loaderRef.watch(WatchViewProviders.watchViewProviders.select((model) => model.isLoadingMore))
                        ? const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CustomAppLoader()),
                      ),
                    )
                        : SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
