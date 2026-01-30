import 'package:flutter/material.dart';
import 'package:the_movies_flutter_app/Utilitles/SharedWidgets/custom_filled_text_button.dart';
import 'package:the_movies_flutter_app/Utilitles/app_theme.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
