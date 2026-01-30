import 'package:flutter/material.dart';

class AppTheme {
  // ---------- Colors ---------
  static const Color transparentColor = Colors.transparent;
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color blackColor = Color.fromRGBO(0, 0, 0, 1);

  static const Color redErrorColor = Color(0xFFFF0F0F);

  static const Color darkPurpleColor = Color(0xFF2E2739);
  static const Color offWhiteColor = Color(0xFFF6F6FA);
  static const Color greyTextColor = Color(0xFF827D88);
  static const Color lightGreyTextColor = Color(0xFF8F8F8F);
  static const Color skyBlueColor = Color(0xFF61C3F2);
  static const Color lightGreyColor = Color(0xFFDBDBDF);
  static const Color tealColor = Color(0xFF15D2BC);
  static const Color pinkColor = Color(0xFFE26CA5);
  static const Color violetColor = Color(0xFF564CA3);
  static const Color goldColor = Color(0xFFCD9D0F);
  static const Color textFieldBgColor = Color(0xFFF2F2F6);
  static const Color hintTextColor = Color(0x4D2C434D);
  static const Color darkBlueTextColor = Color(0xFF202C43);
  static const Color shimmerGrey = Color.fromRGBO(107, 107, 107, 1);

  static final LinearGradient blackAndWhiteTransparentGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.center,
    colors: [AppTheme.blackColor.withAlpha(200), AppTheme.transparentColor],
  );

  //----------- Text Styles -------------
  static TextStyle generalTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    required double fontSize,
    String? fontFamily,
  }) => TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: textColor, fontFamily: fontFamily, inherit: true);

  static TextStyle smallerTextStyle({Color? textColor, FontWeight? fontWeight, double? fontSize, String? fontFamily}) =>
      TextStyle(
        fontSize: fontSize ?? 10,
        fontWeight: fontWeight,
        color: textColor,
        fontFamily: fontFamily ?? AppTheme.appFontFamily,
        inherit: true,
      );

  static TextStyle smallTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    FontStyle? fontStyle,
  }) => TextStyle(
    fontSize: fontSize ?? 12,
    fontWeight: fontWeight,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
    fontStyle: fontStyle ?? FontStyle.normal,
  );

  static TextStyle verySmallTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 9,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle verySmallTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 9,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle smallTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 12,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle regularTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    FontStyle? fontStyle,
  }) => TextStyle(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
    fontStyle: fontStyle ?? FontStyle.normal,
    inherit: true,
  );

  static TextStyle regularLargeTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? height,
  }) => TextStyle(
    fontSize: fontSize ?? 15,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    height: height,
    inherit: true,
  );

  static TextStyle regularTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle mediumTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => TextStyle(
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
    inherit: true,
  );

  static TextStyle mediumTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle mediumRegularTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? height,
    TextDecoration? decoration,
  }) => TextStyle(
    fontSize: fontSize ?? 18,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    height: height,
    decoration: decoration,
    inherit: true,
  );

  static TextStyle mediumNormalLargeTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 20,
    fontWeight: fontWeight,
    color: textColor,
    fontFamily: fontFamily,
    inherit: true,
  );

  static TextStyle mediumLargeTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 22,
    fontWeight: fontWeight,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle mediumLargeTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 22,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle largeTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? height,
  }) => TextStyle(
    fontSize: fontSize ?? 24,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    height: height,
    inherit: true,
  );

  static TextStyle largeRegularStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? height,
  }) => TextStyle(
    fontSize: fontSize ?? 26,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    height: height,
    inherit: true,
  );

  static TextStyle largeTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 24,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle mediumExtraLargeTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 30,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle mediumExtraLargeTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 30,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle mediumRegularExtraLargeTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 32,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle regularExtraLargeTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 35,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle extraLargeTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 38,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  static TextStyle extraLargeTextStyleBold({
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) => TextStyle(
    fontSize: fontSize ?? 38,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor,
    fontFamily: fontFamily ?? AppTheme.appFontFamily,
    inherit: true,
  );

  // --------- Vertical Spacing ----------
  static const verticalSpaceTiny = SizedBox(height: 5.0);
  static const verticalSpaceSmall = SizedBox(height: 10.0);
  static const verticalSpaceRegular = SizedBox(height: 20.0);
  static const verticalSpaceMedium = SizedBox(height: 30.0);
  static const verticalSpaceMediumLarge = SizedBox(height: 35.0);

  static const verticalSpaceLarge = SizedBox(height: 50.0);
  static const verticalSpaceRegularLarge = SizedBox(height: 60.0);

  static const verticalSpaceExtraLarge = SizedBox(height: 100.0);
  static const verticalSpaceVeryExtraLarge = SizedBox(height: 180.0);

  // ----------- Horizontal Spacing ------------
  static const horizontalSpaceVeryTiny = SizedBox(width: 3.0);
  static const horizontalSpaceTiny = SizedBox(width: 5.0);
  static const horizontalSpaceSmall = SizedBox(width: 10.0);
  static const horizontalSpaceRegular = SizedBox(width: 20.0);
  static const horizontalSpaceMedium = SizedBox(width: 30.0);
  static const horizontalSpaceLarge = SizedBox(width: 50.0);
  static const horizontalSpaceExtraLarge = SizedBox(width: 100.0);

  // --------- Screen Paddings -----------
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsetsDirectional screensPadding = EdgeInsetsDirectional.symmetric(horizontal: 16.0, vertical: 40);

  static const double screenPaddingValue = 16.0;

  // ----------- Widget Constraints ----------
  static const BoxConstraints widgetMobileConstraints = BoxConstraints(minWidth: 100, maxWidth: 300);
  static const BoxConstraints widgetTabletConstraints = BoxConstraints(minWidth: 100, maxWidth: 250);

  static BoxConstraints textFieldConstraints(BuildContext context) {
    return (MediaQuery.of(context).size.width >= 500
        ? AppTheme.widgetTabletConstraints
        : AppTheme.widgetMobileConstraints);
  }

  // -------- Screen Size Helpers ----------
  static double screenHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

  static double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
      screenHeight(context) * percentage;

  static double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
      MediaQuery.of(context).size.width;

  // -------- Screen Orientation -----------
  static screenOrientation(BuildContext context) => MediaQuery.of(context).orientation;
  static const String appFontFamily = 'Poppins-Black';
}
