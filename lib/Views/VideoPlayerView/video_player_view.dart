import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movies_flutter_app/Utilitles/SharedWidgets/loading_overlay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../Utilitles/Constants/app_constants.dart';
import '../../Utilitles/app_theme.dart';
import 'video_player_view_providers.dart';

class VideoPlayerView extends ConsumerWidget {
  final int? movieId;

  const VideoPlayerView({super.key, this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trailerYoutubeKey = ref.watch(
      VideoPlayerViewProviders.videoPlayerViewProviders(movieId ?? 0).select((model) => model.trailerYoutubeKey),
    );

    if (trailerYoutubeKey == null) {
      return const Scaffold(body: Center(child: CustomAppLoader()));
    }

    final controller = YoutubePlayerController(
      initialVideoId: trailerYoutubeKey,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    controller.addListener(() {
      if (controller.value.playerState == PlayerState.ended) {
        if (context.canPop()) context.pop();
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  controller.play();
                },
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.greyTextColor,
                  foregroundColor: AppTheme.whiteColor,
                ),
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                child: const Text(AppConstants.doneText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
