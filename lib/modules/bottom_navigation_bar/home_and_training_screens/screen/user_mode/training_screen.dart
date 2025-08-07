import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';

import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/model/video_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/version_chips_row.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/video_list.item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/video_frame_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/user_mode_veiwModel/user_mode_viewModel.dart';
import 'package:provider/provider.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({
    super.key,
    required this.modelData,
    required this.userModel,
  });
  final dynamic modelData;
  final UserModel userModel;

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late UserModeViewmodel userMode;
  late List<VideoModel> allVideos;
  // bool _isControllerInitialized = false;
  // bool isPlayed = false;

  @override
  void initState() {
    super.initState();

    userMode = context.read<UserModeViewmodel>();
    allVideos = userMode.extractAllVideos(widget.modelData);

    if (allVideos.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<UserModeViewmodel>(
          context,
          listen: false,
        ).initializeController(allVideos[0].url);
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserModeViewmodel>(
        context,
        listen: false,
      ).preloadThumbnails(allVideos);
    });

    userMode.startTimer(10);
  }

  int elapsedSeconds = 0;
  @override
  Widget build(BuildContext context) {
    final List<VideoModel> allVideos = this.allVideos;
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.s16),
          child: SingleChildScrollView(
            child: Consumer<UserModeViewmodel>(
              builder: (context, vm, _) {
                double percentDone =
                    vm.totalTime == 0
                        ? 0
                        : (vm.totalTime - vm.remainingSeconds) / vm.totalTime;
                percentDone = percentDone.clamp(0.0, 1.0); // Safety check

                return Column(
                  spacing: Sizes.s20,
                  children: [
                    Row(
                      spacing: Sizes.s10,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              vm.previousVideo();
                              vm.initializeController(
                                allVideos[vm.selectedVideo].url,
                              );
                              // vm.startTimer(
                              //   allVideos[vm.selectedVideo].restTime,
                              // );
                            },
                            preSvgPath: Assets.previous,
                            buttonText: "Previous",
                            textColor: ConstColors.black,
                            buttonColor: ConstColors.secondary,
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            buttonText: "Skip",
                            textColor: ConstColors.black,
                            buttonColor: ConstColors.secondary,
                            postSvgPath: Assets.next,

                            onTap: () {
                              vm.nextVideo(allVideos, context);
                              vm.initializeController(
                                allVideos[vm.selectedVideo].url,
                              );
                              // vm.startTimer(
                              //   allVideos[vm.selectedVideo].restTime,
                              // );
                            },
                          ),
                        ),
                      ],
                    ),

                    if (allVideos[vm.selectedVideo].versionList.isNotEmpty)
                      VersionChipsRow(
                        length: allVideos[vm.selectedVideo].versionList.length,
                        selectedindex: vm.selectedbtn,
                        onSelected: (index) {
                          vm.selectVersionChip(index);
                          vm.initializeController(
                            allVideos[vm.selectedVideo]
                                .versionList[vm.selectedbtn]
                                .url,
                          );
                        },
                      ),
                    Container(
                      width: double.infinity,
                      height: Sizes.s350,
                      color: ConstColors.secondary,

                      child:
                          vm.controller != null && vm.isControllerInitialized
                              ? vm.selectedbtn <= 0
                                  ? VideoFrameScreen(
                                    controller: vm.controller,
                                    // videourl: allVideos[vm.selectedVideo].url,
                                  )
                                  : VideoFrameScreen(
                                    controller: vm.controller,
                                    // videourl:
                                    //     allVideos[vm.selectedVideo]
                                    //         .versionList[vm.selectedbtn]
                                    //         .url,
                                  )
                              : const Center(
                                child: CircularProgressIndicator(
                                  color: ConstColors.black,
                                ),
                              ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: allVideos.length,
                        itemBuilder: (context, index) {
                          final thumb = vm.thumbnailCache[allVideos[index].url];

                          return VideoListItem(
                            tumbnail: thumb,
                            index: index,
                            selectedIndex: vm.selectedVideo,
                            onTap: () {
                              vm.selectVideoItem(index);
                              vm.initializeController(
                                allVideos[vm.selectedVideo].url,
                              );

                              // vm.startTimer(
                              //   allVideos[vm.selectedVideo].restTime,
                              // );
                            },
                          );
                        },
                        separatorBuilder:
                            (context, index) => SizedBox(width: Sizes.s10),
                      ),
                    ),

                    vm.remainingSeconds == 0
                        ? Column(
                          spacing: Sizes.s20,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: Sizes.s20,
                              children: [
                                SizedBox(
                                  width: Sizes.s120,
                                  child: CustomButton(
                                    onTap: () {
                                      vm.playAndPause();
                                    },
                                    buttonText:
                                        vm.controller!.value.isPlaying
                                            ? "PAUSE"
                                            : "PLAY",
                                    textColor: ConstColors.white,

                                    buttonColor:
                                        vm.controller!.value.isPlaying
                                            ? ConstColors.black
                                            : ConstColors.green4AD,
                                    preIconData: CupertinoIcons.pause_solid,
                                  ),
                                ),
                                SizedBox(
                                  width: Sizes.s120,
                                  child: CustomButton(
                                    buttonText: "END",
                                    textColor: ConstColors.white,
                                    buttonColor:
                                        vm.selectedVideo == allVideos.length - 1
                                            ? ConstColors.redF52
                                            : ConstColors.redF52.withValues(
                                              alpha: 0.3,
                                            ),
                                    preSvgPath: Assets.closeSquare,
                                    onTap: () {
                                      if (vm.selectedVideo ==
                                              allVideos.length - 1 &&
                                          vm.remainingSeconds == 0) {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.congrate,
                                          arguments: {
                                            "workoutData": widget.modelData,
                                            "userModel": widget.userModel,
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: Sizes.s10,
                              children: [
                                PoppinsText(
                                  text: allVideos[vm.selectedVideo].name,
                                  fontSize: Sizes.s16,
                                  fontWeight: TextWeight.semiBold,
                                ),
                                SharePicture(imagePath: Assets.swap),
                              ],
                            ),
                            PoppinsText(
                              text: vm.formatDuration(vm.currentPosition),
                              fontSize: Sizes.s24,
                              fontWeight: TextWeight.semiBold,
                            ),
                          ],
                        )
                        : Column(
                          children: [
                            PoppinsText(
                              text: "Get ready!",
                              fontSize: Sizes.s20,
                              fontWeight: TextWeight.semiBold,
                            ),
                            PoppinsText(
                              text: "Pull up",
                              fontSize: Sizes.s12,
                              fontWeight: TextWeight.semiBold,
                              color: ConstColors.greyA1A1,
                            ),
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 8.0,
                              percent: (1 - percentDone).clamp(0.0, 1.0),
                              center: Text(
                                vm.remainingSeconds.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              progressColor: ConstColors.black,
                              backgroundColor: ConstColors.secondary,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: false,
                              animationDuration: 1000,
                            ),
                          ],
                        ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
