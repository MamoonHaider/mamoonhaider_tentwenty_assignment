import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movies_flutter_app/Utilitles/Constants/app_constants.dart';
import 'package:the_movies_flutter_app/Views/HallView/hall_view_providers.dart';
import '../../Models/movie_model.dart';
import '../../Utilitles/HelperFunctions/helper_functions.dart';
import '../../Utilitles/SharedWidgets/cinema_hall_view.dart';
import '../../Utilitles/SharedWidgets/custom_filled_text_button.dart';
import '../../Utilitles/app_theme.dart';
import 'hall_view_widgets.dart';

class HallView extends StatelessWidget {
  const HallView({super.key, this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.whiteColor,
      floatingActionButton: Padding(
        padding: AppTheme.screenPadding,
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppTheme.lightGreyColor),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      AppConstants.totalPriceText,
                      style: AppTheme.smallTextStyle(textColor: AppTheme.blackColor),
                    ),

                    Text(
                      textAlign: TextAlign.center,
                      '\$50',
                      style: AppTheme.smallTextStyleBold(textColor: AppTheme.blackColor),
                    ),
                  ],
                ),
              ),
            ),
            AppTheme.horizontalSpaceSmall,
            Flexible(
              flex: 2,
              child: CustomFilledTextButton(
                backgroundColor: AppTheme.skyBlueColor,
                buttonText: AppConstants.proceedToPayText,

                fontSize: 14,
                fontFamily: AppTheme.appFontFamily,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: .centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppTheme.whiteColor,

              floating: true,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                icon: Icon(Icons.arrow_back_ios, color: AppTheme.blackColor),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  textAlign: TextAlign.center,
                  movie?.title ?? '',
                  style: AppTheme.largeTextStyle(textColor: AppTheme.blackColor, fontWeight: FontWeight.w500),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      movie?.releaseDate != null
                          ? '${HelperFunctions.formatDateToMonthName(movie!.releaseDate)}  I  12:30 hall 1'
                          : AppConstants.releaseDateNotConfirmedText,
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
              child: Center(
                child: Consumer(
                  builder: (context, seatsRef, _) {
                    var selectedSeats = seatsRef.watch(
                      HallViewProviders.hallViewProviders.select((model) => model.selectedSeats),
                    );

                    return CinemaHallView(
                      columns: [5, 5, 6, 8, 10, 10, 10, 8, 6, 5, 5],
                      selectedSeats: selectedSeats,
                      vipSeats: ['1-0', '3-2'],
                      regularSeats: ['0-1', '0-2', '1-1'],
                      unavailableSeats: ['4-5', '5-5'],
                      iconSize: 16,
                      showNumbers: true,
                      onSeatTap: (seatId) {
                        seatsRef.read(HallViewProviders.hallViewProviders.notifier).toggleSeat(seatId);
                      },
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: AppTheme.verticalSpaceSmall),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Wrap(
                  alignment: .center,
                  spacing: 12,
                  runSpacing: 8,
                  children: const [
                    SeatInfoChip(color: AppTheme.goldColor, label: AppConstants.selectedSeatText),
                    SeatInfoChip(color: AppTheme.violetColor, label: AppConstants.vipSeatText),
                    SeatInfoChip(color: AppTheme.skyBlueColor, label: AppConstants.regularSeatText),
                    SeatInfoChip(color: AppTheme.lightGreyTextColor, label: AppConstants.notAvailableSeatText),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: AppTheme.verticalSpaceExtraLarge),
          ],
        ),
      ),
    );
  }
}
