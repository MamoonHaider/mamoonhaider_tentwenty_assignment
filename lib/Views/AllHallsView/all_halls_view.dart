import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movies_flutter_app/Models/movie_model.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/app_constants.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/app_routes_constants.dart';
import 'package:the_movies_flutter_app/Utilitles/HelperFunctions/helper_functions.dart';
import 'package:the_movies_flutter_app/Utilitles/app_theme.dart';
import 'package:the_movies_flutter_app/Views/AllHallsView/all_halls_view_providers.dart';
import 'package:the_movies_flutter_app/Views/MovieDetailsView/movie_details_view_widgets.dart';

import '../../Utilitles/SharedWidgets/custom_filled_text_button.dart';
import 'all_halls_view_widgets.dart';

class AllHallsView extends StatelessWidget {
  const AllHallsView({super.key, this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.whiteColor,
      floatingActionButton: Padding(
        padding: AppTheme.screenPadding,
        child: CustomFilledTextButton(
          onPressed: () {
            context.push(AppRoutesConstants.hallViewRoute, extra: movie);
          },
          backgroundColor: AppTheme.skyBlueColor,
          buttonText: AppConstants.selectSeatsText,
          fontSize: 14,
          fontFamily: AppTheme.appFontFamily,
        ),
      ),

      floatingActionButtonLocation: .centerFloat,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.whiteColor,

            floating: true,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                textAlign: TextAlign.center,
                movie?.title ?? '',
                style: AppTheme.largeTextStyle(textColor: AppTheme.blackColor, fontWeight: FontWeight.w500),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                if (context.canPop()) context.pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: AppTheme.blackColor),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    movie?.releaseDate != null
                        ? '${AppConstants.inTheatersText} ${HelperFunctions.formatDateToMonthName(movie!.releaseDate)}'
                        : '${AppConstants.releaseDateNotConfirmedText}',
                    style: AppTheme.mediumTextStyle(textColor: AppTheme.skyBlueColor),
                  ),
                  AppTheme.verticalSpaceMedium,
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: AppTheme.screenPadding,

              child: Text(
                AppConstants.dateText,
                style: AppTheme.mediumTextStyleBold(textColor: AppTheme.darkBlueTextColor),
              ),
            ),
          ),
          SliverToBoxAdapter(child: AppTheme.verticalSpaceSmall),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 45,
              child: Consumer(
                builder: (context, dateRef, _) {
                  var selectedDateIndex = dateRef.watch(
                    AllHallsViewProviders.allHallsViewProviders.select((model) => model.selectedDateIndex),
                  );
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return DateContainer(
                        label: '${index + 1} March',
                        isSelected: index == selectedDateIndex,
                        onSelect: () {
                          dateRef.read(AllHallsViewProviders.allHallsViewProviders.notifier).setSelectedDate(index);
                        },
                      );
                    },
                    separatorBuilder: (_, __) => AppTheme.horizontalSpaceSmall,
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: AppTheme.verticalSpaceMedium),

          SliverToBoxAdapter(
            child: SizedBox(
              height: AppTheme.screenHeight(context) / 2,
              child: Consumer(
                builder: (context, dateRef, _) {
                  var selectedHallIndex = dateRef.watch(
                    AllHallsViewProviders.allHallsViewProviders.select((model) => model.selectedHallIndex),
                  );
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return HallContainer(
                        label: '${index + 1} March',
                        isSelected: index == selectedHallIndex,
                        onSelect: () {
                          dateRef.read(AllHallsViewProviders.allHallsViewProviders.notifier).setSelectedHall(index);
                        },
                      );
                    },
                    separatorBuilder: (_, __) => AppTheme.horizontalSpaceSmall,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
