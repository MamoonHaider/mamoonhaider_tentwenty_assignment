import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Utilitles/app_theme.dart';
import 'home_view_providers.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = HomeViewProviders.homeViewModelProvider;
    final viewModel = ref.read(HomeViewProviders.homeViewModelProvider.notifier);
    final currentIndex = ref.watch(provider.select((value) => value.index));

    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(27), topRight: Radius.circular(27)),
      child: NavigationBar(
        maintainBottomViewPadding: true,
        height: 70,
        backgroundColor: AppTheme.darkPurpleColor,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => viewModel.setIndex(index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: AppTheme.transparentColor,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          return AppTheme.smallTextStyle(
            textColor: states.contains(WidgetState.selected) ? AppTheme.whiteColor : AppTheme.greyTextColor,
            fontWeight: states.contains(WidgetState.selected) ? FontWeight.w500 : FontWeight.w400,
          );
        }),
        destinations: [
          NavDestination(iconPath: 'assets/icons/dashboard_icon.svg', label: 'Dashboard'),
          NavDestination(iconPath: 'assets/icons/watch_icon.svg', label: 'Watch'),
          NavDestination(iconPath: 'assets/icons/media_library_icon.svg', label: 'Media Library'),
          NavDestination(iconPath: 'assets/icons/more_icon.svg', label: 'More'),
        ],
      ),
    );
  }
}

class NavDestination extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color? selectedColor;
  final Color? unselectedColor;

  const NavDestination({
    super.key,
    required this.iconPath,
    required this.label,
    this.selectedColor = AppTheme.whiteColor,
    this.unselectedColor = AppTheme.greyTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(unselectedColor ?? AppTheme.greyTextColor, BlendMode.srcIn),
      ),
      selectedIcon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(selectedColor ?? AppTheme.whiteColor, BlendMode.srcIn),
      ),
      label: label,
    );
  }
}
