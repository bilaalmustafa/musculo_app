import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/register/component/customVideoPlayer.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/add_version.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/counter_container.dart';
import 'package:video_player/video_player.dart';

class ReelsItem extends StatelessWidget {
  ReelsItem({
    super.key,
    required this.controller,
    this.selected = false,
    this.screenintervel = 0,
  });
  final bool selected;
  int screenintervel;
  final VideoPlayerController controller;
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
            Container(
              height: 80,
              width: 110,

              decoration: BoxDecoration(
                color: ConstColors.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomVideoPlayer(controller: controller),
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
                if (screenintervel == 1)
                  CounterContainer(
                    increment: () {},
                    min: 2,
                    sec: 5,
                    decreament: () {},
                  )
                else if (screenintervel == 2)
                  AddVersion()
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
