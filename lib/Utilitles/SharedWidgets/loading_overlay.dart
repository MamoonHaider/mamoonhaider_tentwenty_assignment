import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isLoading,
      child: Stack(
        children: [
          child,
          if (isLoading)
            Container(
              color: AppTheme.blackColor.withOpacity(0.35),
              child: const Center(child: CustomAppLoader(size: 45)),
            ),
        ],
      ),
    );
  }
}

class CustomAppLoader extends StatelessWidget {
  const CustomAppLoader({super.key, this.size = 30, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(radius: size / 2, color: color ?? AppTheme.skyBlueColor);
  }
}
