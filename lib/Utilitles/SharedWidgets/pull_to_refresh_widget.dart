import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'loading_overlay.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double topDistance;
  final ScrollController? controller;

  const CustomRefreshIndicator({
    required this.child,
    required this.onRefresh,
    this.topDistance = 70.0,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = controller ?? ScrollController();

    return RefreshIndicator(
      displacement: 0,
      elevation: 0,
      color: AppTheme.transparentColor,
      backgroundColor: AppTheme.transparentColor,
      onRefresh: () async {
        if (scrollController.positions.isEmpty) return;
        if (scrollController.position.pixels > 0) return;

        final overlay = Overlay.of(context);
        final entry = OverlayEntry(
          builder: (_) => Positioned(top: topDistance, left: 0, right: 0, child: const CustomAppLoader()),
        );

        overlay.insert(entry);

        try {
          await onRefresh();
        } finally {
          entry.remove();
        }
      },
      child: PrimaryScrollController(controller: scrollController, child: child),
    );
  }
}
