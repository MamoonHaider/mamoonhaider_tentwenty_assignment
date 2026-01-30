import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_movies_flutter_app/Views/HomeView/home_view_widgets.dart';
import 'package:the_movies_flutter_app/Views/MoreView/more_view.dart';

import '../../Utilitles/app_theme.dart';
import '../DashboardView/dashboard_view.dart';
import '../MediaLibraryView/media_library_view.dart';
import '../WatchView/watch_view.dart';
import 'home_view_providers.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> screens = [DashboardView(), WatchView(), MediaLibraryView(), MoreView()];
    final provider = HomeViewProviders.homeViewModelProvider;
    final currentIndex = ref.watch(provider.select((value) => value.index));

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      extendBodyBehindAppBar: true,

      extendBody: true,
      bottomNavigationBar: CustomNavBar(),
      body: screens[currentIndex],
    );
  }
}
