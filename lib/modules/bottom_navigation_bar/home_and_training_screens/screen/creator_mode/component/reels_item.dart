import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/video_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/add_version.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/counter_container.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ReelsItem extends StatelessWidget {
  ReelsItem({
    super.key,

    this.selected = false,
    this.screenintervel = 0,

    this.onTap,
    required this.videodata,
    this.sectionTitle,
    this.index,
  });
  final bool selected;
  int screenintervel;
  final int? index;

  final String? sectionTitle;

  final VideoModel videodata;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: ConstColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? ConstColors.black : ConstColors.transparent,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Row(
          spacing: 10,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 80,
                  width: 110,

                  decoration: BoxDecoration(
                    color: ConstColors.secondary,
                    borderRadius: BorderRadius.circular(16),
                    image:
                        videodata.thumbnailPath != null
                            ? DecorationImage(
                              image: FileImage(File(videodata.thumbnailPath!)),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  // child: CustomVideoPlayer(controller: controller),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.play_circle_fill_outlined,
                    color: ConstColors.white,
                    size: 30,
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              mainAxisSize: MainAxisSize.max,
              children: [
                PoppinsText(
                  text: videodata.name,
                  fontSize: Sizes.s12,
                  fontWeight: TextWeight.semiBold,
                ),
                if (screenintervel == 1)
                  Consumer<AddWorkoutVeiwModel>(
                    builder: (context, vm, _) {
                      return CounterContainer(
                        intervalSeconds: videodata.intervalSeconds,

                        onChanged: (newsecond) {
                          log("  tonchanging   $newsecond");
                          log("  sectionTitle   $sectionTitle  $index");
                          if (sectionTitle != null && index != null) {
                            log("  onchanging   $newsecond");
                            vm.updateintervelTime(
                              sectionTitle!,
                              index!,
                              newsecond,
                            );
                          }
                        },
                      );
                    },
                  )
                else if (screenintervel == 2)
                  AddVersion(
                    intervelTime: videodata.intervalSeconds,
                    videomodelData: videodata,
                  )
                else
                  Row(
                    spacing: 10,
                    children: [
                      CustomChip(text: "warmup", color: ConstColors.secondary),
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
              child: SharePicture(
                imagePath:
                    screenintervel == 0
                        ? Assets.heartIcon
                        : Assets.moreHrizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
