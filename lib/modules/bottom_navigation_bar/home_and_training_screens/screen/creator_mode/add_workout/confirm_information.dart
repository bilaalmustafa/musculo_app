import 'package:flutter/material.dart';

import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/counter_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';
import 'package:video_player/video_player.dart';

class ConfirmInformation extends StatefulWidget {
  const ConfirmInformation({super.key});

  @override
  State<ConfirmInformation> createState() => _WarmUpState();
}

class _WarmUpState extends State<ConfirmInformation> {
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

  List<Map<String, dynamic>> listinfo = [
    {"Workoutname": "Simple"},
    {"Type": "With out Equipment"},
    {"added to": "Warm up-workout"},
    {"Difficuly": "5/7"},
    {"Level": "Biginner"},
    {"Gender": "Male"},
    {"Total time": "10 hours"},
    {"Price": "  \$40"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Column(
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
                    text: "Confirm the information below",
                    fontSize: Sizes.s20,
                    fontWeight: TextWeight.semiBold,
                  ),
                  PoppinsText(
                    text: "Training details",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ConstColors.secondary,

                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(listinfo.length, (index) {
                        final enty = listinfo[index].entries.first;
                        return ListTile(
                          leading: PoppinsText(
                            text: enty.key,
                            fontSize: Sizes.s12,
                            color: ConstColors.greyA1A1,
                          ),
                          trailing: PoppinsText(
                            text: enty.value.toString(),
                            fontSize: Sizes.s12,
                            color: ConstColors.black,
                          ),
                        );
                      }),
                    ),
                  ),
                  PoppinsText(
                    text: "Warm Up",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),

                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final controller = _controllers[index];
                      return ReelsItem(
                        controller: controller,
                        screenintervel: 2,
                      );
                    },
                    separatorBuilder: (contxt, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PoppinsText(
                            text: "Rest time",
                            fontSize: Sizes.s14,
                            fontWeight: TextWeight.semiBold,
                          ),
                          CounterContainer(
                            increment: () {},
                            decreament: () {},
                            min: 1,
                            sec: 30,
                          ),
                        ],
                      );
                    },
                    itemCount: videoUrls.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
