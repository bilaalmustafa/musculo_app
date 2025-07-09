import 'package:flutter/material.dart';
import 'package:musculo_app/modules/auth/register/component/customVideoPlayer.dart';
import 'package:video_player/video_player.dart';

class VideoFrameScreen extends StatefulWidget {
  VideoFrameScreen({super.key, required this.videourl, this.controller});
  final String videourl;
  VideoPlayerController? controller;
  @override
  State<VideoFrameScreen> createState() => _VideoFrameScreenState();
}

class _VideoFrameScreenState extends State<VideoFrameScreen> {
  // late VideoPlayerController _controller;
  bool _isInitialized = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeVideo();
  // }

  // @override
  // void didUpdateWidget(covariant VideoFrameScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.videourl != widget.videourl) {
  //     _controller.dispose();
  //     _initializeVideo();
  //   }
  // }

  // void _initializeVideo() {
  //   _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videourl))
  //     ..initialize().then((_) {
  //       setState(() {
  //         _isInitialized = true;
  //       });
  //     });
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // void _togglePlayPause() {
  //   setState(() {
  //     if  (widget. controller.value.isPlaying) {
  //       widget. controller.pause();
  //       _isPlaying = false;
  //     } else {
  //       widget. controller.play();
  //       _isPlaying = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:
              widget.controller != null &&
                      widget.controller!.value.isInitialized
                  ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: AspectRatio(
                          aspectRatio: widget.controller!.value.aspectRatio,
                          child: VideoPlayer(widget.controller!),
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   height: 300,
                      //   color: Colors.black26, // transparent overlay
                      //   child: Center(
                      //     child: Icon(
                      //       widget. controller!.value.isPlaying
                      //           ? Icons.pause_circle_filled
                      //           : Icons.play_circle_fill,
                      //       size: 64,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                  : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
