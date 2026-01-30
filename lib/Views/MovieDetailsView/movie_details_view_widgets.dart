import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Utilitles/app_theme.dart';

class GenreChip extends StatelessWidget {
  final String label;
  final Color color;

  const GenreChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: AppTheme.smallTextStyle(textColor: AppTheme.whiteColor, fontWeight: FontWeight.w500),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}


class MovieDetailsShimmer extends StatelessWidget {
  const MovieDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: isLandscape
          ? Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: screenHeight,
                    child: Stack(
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppTheme.shimmerGrey.withAlpha(100),
                          highlightColor: AppTheme.whiteColor.withAlpha(100),
                          child: Container(
                            width: double.infinity,
                            height: screenHeight,
                            decoration: BoxDecoration(
                              color: AppTheme.shimmerGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        Container(
                          height: screenHeight,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AppTheme.blackColor.withAlpha(100), AppTheme.transparentColor],
                            ),
                          ),
                        ),

                        Container(
                          height: screenHeight,
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
                              Shimmer.fromColors(
                                baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                highlightColor: AppTheme.whiteColor.withAlpha(100),
                                child: Container(width: 150, height: 20, color: AppTheme.shimmerGrey),
                              ),
                              AppTheme.verticalSpaceRegular,
                              Row(
                                children: [
                                  Expanded(
                                    child: Shimmer.fromColors(
                                      baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                      highlightColor: AppTheme.whiteColor.withAlpha(100),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppTheme.shimmerGrey,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AppTheme.horizontalSpaceSmall,
                                  Expanded(
                                    child: Shimmer.fromColors(
                                      baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                      highlightColor: AppTheme.whiteColor.withAlpha(100),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppTheme.shimmerGrey,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: AppTheme.screenPadding,

                    child: Column(
                      crossAxisAlignment: .start,

                      children: [
                        AppTheme.verticalSpaceLarge,
                        Padding(
                          padding: AppTheme.screenPadding,
                          child: Shimmer.fromColors(
                            baseColor: AppTheme.shimmerGrey.withAlpha(100),
                            highlightColor: AppTheme.whiteColor.withAlpha(100),
                            child: Container(width: 80, height: 20, color: AppTheme.shimmerGrey),
                          ),
                        ),
                        AppTheme.verticalSpaceSmall,

                        Padding(
                          padding: AppTheme.screenPadding,
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: List.generate(5, (index) {
                              return Shimmer.fromColors(
                                baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                highlightColor: AppTheme.whiteColor.withAlpha(100),
                                child: Container(
                                  width: 60,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: AppTheme.shimmerGrey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        AppTheme.verticalSpaceMedium,

                        Padding(
                          padding: AppTheme.screenPadding,
                          child: Shimmer.fromColors(
                            baseColor: AppTheme.shimmerGrey.withAlpha(100),
                            highlightColor: AppTheme.whiteColor.withAlpha(100),
                            child: Container(width: 80, height: 20, color: AppTheme.shimmerGrey),
                          ),
                        ),
                        AppTheme.verticalSpaceSmall,

                        Padding(
                          padding: AppTheme.screenPadding,
                          child: Column(
                            crossAxisAlignment: .start,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Shimmer.fromColors(
                                  baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                  highlightColor: AppTheme.whiteColor.withAlpha(100),
                                  child: Container(width: double.infinity, height: 14, color: AppTheme.shimmerGrey),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(
                  height: screenHeight / 1.8,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppTheme.shimmerGrey.withAlpha(100),
                        highlightColor: AppTheme.whiteColor.withAlpha(100),
                        child: Container(
                          width: double.infinity,
                          height: screenHeight / 1.8,
                          color: AppTheme.shimmerGrey,
                        ),
                      ),
                      Container(
                        height: screenHeight / 1.8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [AppTheme.blackColor.withAlpha(50), AppTheme.transparentColor],
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight / 1.8,
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
                              Shimmer.fromColors(
                                baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                highlightColor: AppTheme.whiteColor.withAlpha(100),
                                child: Container(width: 150, height: 20, color: AppTheme.shimmerGrey),
                              ),
                              AppTheme.verticalSpaceRegular,
                              Shimmer.fromColors(
                                baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                highlightColor: AppTheme.whiteColor.withAlpha(100),
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.shimmerGrey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              AppTheme.verticalSpaceSmall,
                              Shimmer.fromColors(
                                baseColor: AppTheme.shimmerGrey.withAlpha(100),
                                highlightColor: AppTheme.whiteColor.withAlpha(100),
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.shimmerGrey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                AppTheme.verticalSpaceMedium,

                Padding(
                  padding: AppTheme.screenPadding,
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppTheme.shimmerGrey.withAlpha(100),
                        highlightColor: AppTheme.whiteColor.withAlpha(100),
                        child: Container(width: 100, height: 20, color: AppTheme.shimmerGrey),
                      ),
                    ],
                  ),
                ),
                AppTheme.verticalSpaceSmall,

                Padding(
                  padding: AppTheme.screenPadding,

                  child: Wrap(
                    spacing: 4,
                    runSpacing: 0,
                    children: List.generate(5, (index) {
                      return Shimmer.fromColors(
                        baseColor: AppTheme.shimmerGrey.withAlpha(100),
                        highlightColor: AppTheme.whiteColor.withAlpha(100),
                        child: Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(
                            color: AppTheme.shimmerGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                AppTheme.verticalSpaceSmall,

                Padding(
                  padding: AppTheme.screenPadding,
                  child: Shimmer.fromColors(
                    baseColor: AppTheme.shimmerGrey.withAlpha(100),
                    highlightColor: AppTheme.whiteColor.withAlpha(100),
                    child: Container(height: 1, color: AppTheme.shimmerGrey),
                  ),
                ),
                AppTheme.verticalSpaceSmall,

                Padding(
                  padding: AppTheme.screenPadding,
                  child: Shimmer.fromColors(
                    baseColor: AppTheme.shimmerGrey.withAlpha(100),
                    highlightColor: AppTheme.whiteColor.withAlpha(100),
                    child: Container(width: 80, height: 20, color: AppTheme.shimmerGrey),
                  ),
                ),
                AppTheme.verticalSpaceSmall,

                Padding(
                  padding: AppTheme.screenPadding,

                  child: Column(
                    crossAxisAlignment: .start,
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Shimmer.fromColors(
                          baseColor: AppTheme.shimmerGrey.withAlpha(100),
                          highlightColor: AppTheme.whiteColor.withAlpha(100),
                          child: Container(width: double.infinity, height: 14, color: AppTheme.shimmerGrey),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}

class GenreColors {
  static const Color action = Color(0xFF15D2BC);
  static const Color thriller = Color(0xFFE26CA5);
  static const Color science = Color(0xFF564CA3);
  static const Color fiction = Color(0xFFCD9D0F);
  static const Color fantasy = Color(0xFF8E44AD);
  static const Color comedy = Color(0xFFFFC107);
  static const Color horror = Color(0xFFE74C3C);
  static const Color defaultColor = Color(0xFFB0B0B0);

  static Color getColor(String genreName) {
    switch (genreName.toLowerCase()) {
      case 'action':
        return action;
      case 'thriller':
        return thriller;
      case 'science fiction':
      case 'sci-fi':
      case 'science':
        return science;
      case 'fiction':
        return fiction;
      case 'fantasy':
        return fantasy;
      case 'comedy':
        return comedy;
      case 'horror':
        return horror;
      default:
        return defaultColor; // fallback color
    }
  }
}
