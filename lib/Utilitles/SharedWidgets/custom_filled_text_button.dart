import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustomFilledTextButton extends StatelessWidget {
  const CustomFilledTextButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.buttonText,
    this.textColor,
    this.roundness,
    this.borderColor,
    this.borderThickness,
    this.buttonTextStyle,
    this.child,
    this.fontSize,
    this.fontWeight,
    this.innerPadding,
    this.icon,
    this.height,
    this.fontFamily,
  });

  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final String? buttonText;
  final Color? textColor;
  final double? roundness;
  final double? borderThickness;
  final Color? borderColor;
  final TextStyle? buttonTextStyle;
  final double? fontSize;
  final Widget? child;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? innerPadding;
  final Widget? icon;
  final double? height;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? AppTheme.whiteColor;
    final hasSolidColor = backgroundColor != null;

    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        child: Container(
          height: height,
          width: double.infinity,
          padding: innerPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            color: hasSolidColor ? backgroundColor : null,

            border: borderColor != null ? Border.all(color: borderColor!, width: borderThickness ?? 1) : null,
            borderRadius: BorderRadius.circular(roundness ?? 10),
          ),

          child:
              child ??
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, const SizedBox(width: 8)],
                  Flexible(
                    child: Text(
                      buttonText ?? 'Click Here',
                      textAlign: TextAlign.center,
                      style:
                          buttonTextStyle ??
                          TextStyle(
                            color: effectiveTextColor,
                            fontSize: fontSize ?? 26,
                            fontWeight: fontWeight ?? FontWeight.bold,
                            fontFamily: fontFamily ?? AppTheme.appFontFamily,
                          ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
