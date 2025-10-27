import 'package:flutter/material.dart';

import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';
import 'package:provider/provider.dart';

class ScaleVersion extends StatefulWidget {
  const ScaleVersion({super.key});

  @override
  State<ScaleVersion> createState() => _WarmUpState();
}

class _WarmUpState extends State<ScaleVersion> {
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
                  text: "Choose scale version for the chosen exercises",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
                ),
              ],
            ),
          ),

          Expanded(
            child: Consumer<AddWorkoutVeiwModel>(
              builder: (context, vm, _) {
                return Container(
                  color: ConstColors.secondary,
                  padding: EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: vm.selectedVideos.length,
                    itemBuilder: (context, ind) {
                      final sectionTitle = vm.selectedVideos.keys.elementAt(
                        ind,
                      );
                      final videos = vm.selectedVideos[sectionTitle]!;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final video = videos.elementAt(index);
                          final int minutes = video.restTime ~/ 60;
                          final int seconds = video.restTime % 60;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              spacing: 5,
                              children: [
                                ReelsItem(
                                  videodata: video,
                                  screenintervel: 2,
                                  index: index,
                                  onRemoveTap: () {
                                    Provider.of<AddWorkoutVeiwModel>(
                                      context,
                                      listen: false,
                                    ).removeSelectedVideo(sectionTitle, video);
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PoppinsText(
                                      text: "Rest time",
                                      fontSize: Sizes.s14,
                                      fontWeight: TextWeight.semiBold,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ConstColors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: PoppinsText(
                                        text:
                                            "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                                        fontSize: 10,
                                        color: ConstColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemCount: videos.length,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
