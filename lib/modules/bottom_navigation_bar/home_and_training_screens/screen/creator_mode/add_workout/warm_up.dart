import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:video_player/video_player.dart';

class WarmUp extends StatefulWidget {
  const WarmUp({super.key});

  @override
  State<WarmUp> createState() => _WarmUpState();
}

class _WarmUpState extends State<WarmUp> {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
  ];
  final List<VideoPlayerController> _controllers = [];
  @override
  void initState() {
    super.initState();
    for (var url in videoUrls) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      controller
          .initialize()
          .then((_) {
            print("Initialized video: $url");
            setState(() {});
          })
          .catchError((error) {
            print("Error initializing video: $error");
          });
      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        spacing: Sizes.s20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                PoppinsText(
                  text: "Warm Up",
                  fontSize: Sizes.s20,
                  fontWeight: TextWeight.semiBold,
                ),

                CustomTextField(
                  title: "search exercise",
                  suffexicon: Icons.filter,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: "Select exercises",
                      fontSize: Sizes.s16,
                      fontWeight: TextWeight.semiBold,
                    ),
                    PoppinsText(
                      text: "650 found",
                      fontSize: Sizes.s12,
                      fontWeight: TextWeight.semiBold,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: ConstColors.secondary,
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final controller = _controllers[index];
                  return Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ConstColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5,
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Container(
                            height: 80,
                            width: 110,

                            decoration: BoxDecoration(
                              color: ConstColors.amber,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child:
                                controller.value.isInitialized
                                    ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: AspectRatio(
                                            aspectRatio:
                                                controller.value.aspectRatio,
                                            child: VideoPlayer(controller),
                                          ),
                                        ),
                                        Icon(
                                          Icons.play_circle_outline,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ],
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 5,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              PoppinsText(
                                text: "Dancer",
                                fontSize: Sizes.s14,
                                fontWeight: TextWeight.semiBold,
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  CustomChip(
                                    text: "warmup",
                                    color: ConstColors.secondary,
                                  ),
                                  CustomChip(
                                    text: "stability",
                                    color: ConstColors.secondary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.favorite_border_outlined),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: videoUrls.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
