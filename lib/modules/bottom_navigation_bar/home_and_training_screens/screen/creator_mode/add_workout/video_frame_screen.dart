import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:video_player/video_player.dart';

class VideoFrameScreen extends StatefulWidget {
 const VideoFrameScreen({super.key,   this.controller});
  // final String videourl;
 final  VideoPlayerController? controller;
  @override
  State<VideoFrameScreen> createState() => _VideoFrameScreenState();
}

class _VideoFrameScreenState extends State<VideoFrameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Center(
        child:
            widget.controller != null && widget.controller!.value.isInitialized
                ? Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: context.screenheight * 0.4,
                      child: AspectRatio(
                        aspectRatio: widget.controller!.value.aspectRatio,
                        child: VideoPlayer(widget.controller!),
                      ),
                    ),
                 
                  ],
                )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
