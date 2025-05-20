import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;
  final double borderRadius;
  final double iconSize;

  const CustomVideoPlayer({
    Key? key,
    required this.controller,
    this.borderRadius = 16.0,
    this.iconSize = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: VideoPlayer(controller),
            ),
            Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: iconSize,
            ),
          ],
        )
        : const Center(
          child: CircularProgressIndicator(color: ConstColors.black),
        );
  }
}
