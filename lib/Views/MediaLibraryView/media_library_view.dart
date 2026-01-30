import 'package:flutter/material.dart';

import '../../Utilitles/SharedWidgets/custom_filled_text_button.dart';
import '../../Utilitles/app_theme.dart';

class MediaLibraryView extends StatelessWidget {
  const MediaLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppTheme.screenPadding,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                CustomFilledTextButton(
                  buttonText: 'Search Movies',
                  backgroundColor: AppTheme.skyBlueColor,
                  textColor: AppTheme.whiteColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
