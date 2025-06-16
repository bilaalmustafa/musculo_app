import 'package:flutter/material.dart';
import 'package:musculo_app/modules/auth/register/component/customVideoPlayer.dart';
import 'package:video_player/video_player.dart';

class VideoFrameScreen extends StatefulWidget {
  const VideoFrameScreen({super.key, required this.videourl});
  final String videourl;

  @override
  State<VideoFrameScreen> createState() => _VideoFrameScreenState();
}

class _VideoFrameScreenState extends State<VideoFrameScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videourl));

    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint("Error initializing video: $e");
      setState(() {
        _isInitialized = false;
      });
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:
              _isInitialized
                  ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: CustomVideoPlayer(controller: _controller),
                      ),
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.black26, // transparent overlay
                          child: Center(
                            child: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              size: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
