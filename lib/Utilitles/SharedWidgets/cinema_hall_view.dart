import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_theme.dart';

class CinemaHallView extends StatelessWidget {
  final List<int> columns;
  final void Function(String seatId) onSeatTap;
  final bool showNumbers;
  final double iconSize;

  final List<String> selectedSeats;
  final List<String> vipSeats;
  final List<String> regularSeats;
  final List<String> unavailableSeats;

  const CinemaHallView({
    super.key,
    required this.columns,
    required this.onSeatTap,
    this.showNumbers = false,
    this.iconSize = 8.0,
    this.selectedSeats = const [],
    this.vipSeats = const [],
    this.regularSeats = const [],
    this.unavailableSeats = const [],
  });

  @override
  Widget build(BuildContext context) {
    final maxRows = columns.isNotEmpty ? columns.reduce((currentMax, columnLength) => currentMax > columnLength ? currentMax : columnLength) : 0;
    final seatMargin = iconSize * 0.15;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: showNumbers ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        if (showNumbers) ...[
          Padding(
            padding: EdgeInsets.only(left: iconSize * 0.6, top: iconSize * 3.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(maxRows, (rowIndex) {
                return Container(
                  height: iconSize + seatMargin * 2,
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${rowIndex + 1}',
                    style: TextStyle(fontSize: iconSize, color: AppTheme.greyTextColor),
                  ),
                );
              }),
            ),
          ),
          SizedBox(width: iconSize * 0.3),
        ],

        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 300,
              height: iconSize * 4,
              decoration: BoxDecoration(
                color: AppTheme.skyBlueColor,
                border: Border(top: BorderSide(color: AppTheme.skyBlueColor, width: 2)),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppTheme.skyBlueColor, AppTheme.whiteColor, AppTheme.whiteColor, AppTheme.whiteColor],
                  stops: [0.0, 0.2, 0.5, 1.0],
                ),
              ),
            ),

            // Seat columns
            Padding(
              padding: EdgeInsets.only(top: iconSize * 3.5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: columns.asMap().entries.map((entry) {
                  final colIndex = entry.key;
                  final rowCount = entry.value;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: iconSize * 0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(rowCount, (rowIndex) {
                        final seatId = '$colIndex-$rowIndex';
                        Color seatColor = AppTheme.lightGreyTextColor;
                        bool isClickable = true;

                        if (unavailableSeats.contains(seatId)) {
                          seatColor = AppTheme.lightGreyTextColor;
                          isClickable = false; // not clickable
                        } else if (selectedSeats.contains(seatId)) {
                          seatColor = AppTheme.goldColor;
                        } else if (vipSeats.contains(seatId)) {
                          seatColor = AppTheme.violetColor;
                        } else if (regularSeats.contains(seatId)) {
                          seatColor = AppTheme.skyBlueColor;
                        }

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: seatMargin),
                          width: iconSize,
                          height: iconSize,
                          child: GestureDetector(
                            onTap: isClickable ? () => onSeatTap(seatId) : null,
                            child: SvgPicture.asset(
                              'assets/icons/seat_icon.svg',
                              height: iconSize,
                              width: iconSize,
                              color: seatColor,
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }).toList(),
              ),
            ),

            Container(
              width: 300,
              height: iconSize * 4,
              decoration: BoxDecoration(
                color: AppTheme.transparentColor,
                border: Border(top: BorderSide(color: AppTheme.skyBlueColor, width: 2)),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
