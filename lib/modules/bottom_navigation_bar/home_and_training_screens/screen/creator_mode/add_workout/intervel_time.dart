import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/counter_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';
import 'package:provider/provider.dart';


class IntervelTime extends StatefulWidget {
  const IntervelTime({super.key});

  @override
  State<IntervelTime> createState() => _WarmUpState();
}

class _WarmUpState extends State<IntervelTime> {
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
            child: Consumer<AddWorkoutVeiwModel>(
              builder: (context, vm, _) {
                return Container(
                  color: ConstColors.secondary,
                  padding: EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: vm.selectedVideos.length,
                    itemBuilder: (context, indx) {
                      final sectionTitle = vm.selectedVideos.keys.elementAt(
                        indx,
                      );
                      final videos = vm.selectedVideos[sectionTitle]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PoppinsText(
                            text: sectionTitle,
                            fontSize: Sizes.s18,
                            fontWeight: TextWeight.semiBold,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final video = videos.elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    ReelsItem(
                                      videodata: video,
                                      screenintervel: 1,
                                      index: index,
                                      sectionTitle: sectionTitle,
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
                                        CounterContainer(
                                          onChanged: (newsecond) {
                                            log(
                                              " changing function $newsecond",
                                            );
                                            vm.updateRestTime(
                                              sectionTitle,
                                              index,
                                              newsecond,
                                            );
                                          },
                                          intervalSeconds: video.restTime,
                                          boxColor: ConstColors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 5);
                            },
                            itemCount: videos.length,
                          ),
                        ],
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
