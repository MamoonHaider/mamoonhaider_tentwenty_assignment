import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Utilitles/SharedWidgets/cinema_hall_view.dart';
import '../../Utilitles/app_theme.dart';

class DateContainer extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const DateContainer({super.key, required this.label, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? AppTheme.skyBlueColor : AppTheme.lightGreyColor;

    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(isSelected ? 1.05 : 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),

        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.skyBlueColor.withAlpha(100),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTheme.mediumTextStyle(
            textColor: isSelected ? AppTheme.whiteColor : AppTheme.greyTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class HallContainer extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const HallContainer({super.key, required this.label, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Text('12:30', style: AppTheme.mediumTextStyleBold(textColor: AppTheme.darkBlueTextColor)),
              AppTheme.horizontalSpaceSmall,
              Text('Cinetech + Hall 1', style: AppTheme.mediumTextStyle(textColor: AppTheme.greyTextColor)),
            ],
          ),
          AppTheme.verticalSpaceSmall,
          AnimatedContainer(
            height: AppTheme.screenHeight(context) / 3.8,
            width: AppTheme.screenWidth(context) / 1.3,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            transform: Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),

            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isSelected ? AppTheme.skyBlueColor : AppTheme.lightGreyColor, width: 1),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppTheme.skyBlueColor.withAlpha(100),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ]
                  : [],
            ),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CinemaHallView(
                columns: [5, 5, 6, 8, 10, 10, 10, 8, 6, 5, 5],
                selectedSeats: [],
                iconSize: 8,
                showNumbers: false,
                onSeatTap: (seatId) {},
              ),
            ),
          ),

          AppTheme.verticalSpaceSmall,
          Row(
            children: [
              Text('From', style: AppTheme.mediumTextStyle(textColor: AppTheme.greyTextColor)),
              AppTheme.horizontalSpaceTiny,

              Text('50\$', style: AppTheme.mediumTextStyleBold(textColor: AppTheme.darkBlueTextColor)),
              AppTheme.horizontalSpaceTiny,

              Text('or', style: AppTheme.mediumTextStyle(textColor: AppTheme.greyTextColor)),

              AppTheme.horizontalSpaceTiny,
              Text('2500 bonus', style: AppTheme.mediumTextStyleBold(textColor: AppTheme.blackColor)),
            ],
          ),
        ],
      ),
    );
  }
}

