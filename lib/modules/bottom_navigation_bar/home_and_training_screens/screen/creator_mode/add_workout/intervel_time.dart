import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/counter_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';
import 'package:video_player/video_player.dart';

class IntervelTime extends StatefulWidget {
  const IntervelTime({super.key});

  @override
  State<IntervelTime> createState() => _WarmUpState();
}

class _WarmUpState extends State<IntervelTime> {
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

  Set<int> seletedList = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        spacing: Sizes.s20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                PoppinsText(
                  text: "Choose the interval time for the chosen exercises",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ReelsItem(
                      screenintervel: 1,
                      selected: seletedList.contains(index),
                      controller: controller,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PoppinsText(
                        text: "Reset time",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.semiBold,
                      ),
                      CounterContainer(
                        boxColor: ConstColors.white,
                        increment: () {},
                        decreament: () {},
                        min: 1,
                        sec: 3,
                      ),
                    ],
                  );
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
