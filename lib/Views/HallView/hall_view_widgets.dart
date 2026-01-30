import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Utilitles/app_theme.dart';
class SeatInfoChip extends StatelessWidget {
  final Color color;
  final String label;

  const SeatInfoChip({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/seat_icon.svg',
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            AppTheme.horizontalSpaceSmall,
            Text(label),
          ],
        ),
      ],
    );
  }
}
