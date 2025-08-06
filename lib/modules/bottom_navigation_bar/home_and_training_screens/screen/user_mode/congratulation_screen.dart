import 'package:flutter/material.dart';

import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/congrate_container.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/show_share_bottom_sheet.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/user_mode_veiwModel/user_mode_viewModel.dart';
import 'package:provider/provider.dart';

import '../../../../../model/user_model.dart';
import '../../component/show_rating_bottom_sheet.dart';

class CongratulationScreen extends StatefulWidget {
  final UserModel creator;
  final dynamic vedioData;
  const CongratulationScreen({
    super.key,
    required this.creator,
    required this.vedioData,
  });

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  final GlobalKey _shareKey = GlobalKey();
  late UserModeViewmodel userMode;
  late List<VideoModel> allVideos;

  @override
  void initState() {
    userMode = context.read<UserModeViewmodel>();
    allVideos = userMode.extractAllVideos(widget.vedioData);
    userMode.updateUserWorkoutStats(
      userId: widget.creator.userId ?? '',
      finishedWorkoutCount: allVideos.length,
      minutesSpent: widget.vedioData.totalTime ?? 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final allVideos =
    //     widget.vedioData.categorizedVideos?.values
    //         .expand((v) => v)
    //         .toList() ??
    //     [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: UserService().userByIdstream(widget.vedioData.userId ?? ""),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(Sizes.s20),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  spacing: Sizes.s14,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Sizes.s20),
                    RepaintBoundary(
                      key: _shareKey,
                      child: Container(
                        width: double.infinity,
                        color: ConstColors.white,
                        child: Column(
                          spacing: Sizes.s14,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SharePicture(
                              imagePath: Assets.congrate,
                              width: Sizes.s250,
                              height: Sizes.s250,
                            ),
                            PoppinsText(
                              text: "Congratulation!",
                              fontSize: Sizes.s26,
                              fontWeight: TextWeight.semiBold,
                            ),
                            PoppinsText(
                              text: "You’ve completed the workout!",
                              fontSize: Sizes.s13,
                              fontWeight: TextWeight.regular,
                              color: ConstColors.greyA1A1,
                            ),

                            Row(
                              children: [
                                CongrateContainer(
                                  imagePath: Assets.runnerIcon,
                                  digit: "${allVideos.length}",
                                  text: "Finished Workout",
                                ),
                                CongrateContainer(
                                  imagePath: Assets.timeCircle,
                                  digit: "${widget.vedioData.totalTime}",
                                  text: "Minutes Spent",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      preIconData: Icons.camera_enhance,
                      buttonText: "Share Training",
                      buttonColor: ConstColors.secondary,
                      textColor: ConstColors.black,
                      onTap: () {
                        showModalBottomSheet(
                          barrierColor: ConstColors.black.withValues(
                            alpha: 0.8,
                          ),
                          constraints: BoxConstraints(maxHeight: 300),
                          backgroundColor: ConstColors.white,
                          context: context,
                          builder: (context) {
                            return ShowShareBottomSheet(shareKey: _shareKey);
                          },
                        );
                      },
                    ),
                    SizedBox(height: Sizes.s54),
                    Row(
                      spacing: Sizes.s12,
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonText: "Rate creator",
                            buttonColor: ConstColors.secondary,
                            textColor: ConstColors.black,
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: ConstColors.black.withValues(
                                  alpha: 0.8,
                                ),
                                constraints: BoxConstraints(maxHeight: 500),
                                backgroundColor: ConstColors.white,
                                context: context,
                                builder: (context) {
                                  return ShowRatingBottomSheet(creator: data!);
                                },
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            buttonText: "Back home",
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.bottomnavigationbarscreen,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
