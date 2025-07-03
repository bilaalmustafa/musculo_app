import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/analysis_containers.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/paragraph_text.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/component/show_rating_sheet.dart';

import '../../../../core/config/routes.dart';
import '../../../../core/services/user_service.dart';
import '../../../../model/user_model.dart';

class TraningPreviewScreen extends StatefulWidget {
  const TraningPreviewScreen({super.key, required this.workoutModel});

  final WorkoutModel workoutModel;
  @override
  State<TraningPreviewScreen> createState() => _TraningPreviewScreenState();
}

class _TraningPreviewScreenState extends State<TraningPreviewScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final data = widget.workoutModel;
    Map<String, String> formatProgramTimeParts(int totalTimeInSeconds) {
      int totalMinutes = totalTimeInSeconds ~/ 60;

      if (totalMinutes < 60) {
        return {'digit': '$totalMinutes', 'unit': 'Minutes'};
      } else {
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;

        if (minutes >= 45) {
          hours += 1;
        }

        return {'digit': '$hours', 'unit': 'Hours'};
      }
    }

    final timeParts = formatProgramTimeParts(data.totalTime!);
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: ConstColors.black,
                width: double.infinity,
                height: context.screenheight * 0.3,
                child: SharePicture(
                  imagePath: Assets.bellyFat,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: context.screenheight * .07,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SharePicture(
                    imagePath: Assets.arrowleft,
                    colorFilter: ColorFilter.mode(
                      ConstColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: context.screenheight * 0.05,
                right: 10,
                child: PopupMenuButton<String>(
                  color: ConstColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (value) {
                    if (value == 'Rate') {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: ConstColors.black.withValues(alpha: .8),
                        constraints: BoxConstraints(
                          maxHeight: context.screenheight * 0.7,
                        ),
                        backgroundColor: ConstColors.white,
                        context: context,
                        builder: (context) {
                          return ShowrateSheet(
                            workoutModel: widget.workoutModel,
                          );
                        },
                      );
                    }

                    if (value == "feedback") {
                      Navigator.pushNamed(
                        context,
                        Routes.feedbScreen,
                        arguments: {
                          'feedbackType': 'WorkOut',
                          'contentId': widget.workoutModel.workoutId,
                          'rating': widget.workoutModel.rating,
                          'contentName': widget.workoutModel.workoutName,
                        },
                      );
                    }
                    if (value == "report") {
                      Navigator.pushNamed(
                        context,
                        Routes.reportScreen,
                        arguments: {
                          'reportType': 'Report workOut',
                          'contentId': widget.workoutModel.workoutId,
                          'rating': widget.workoutModel.rating,
                          'contentName': widget.workoutModel.workoutName,
                        },
                      );
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'Rate',
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_border_outlined,
                                color: ConstColors.black,
                              ),
                              SizedBox(width: Sizes.s8),
                              PoppinsText(
                                text: 'Rate Workout',
                                fontSize: Sizes.s14,
                                fontWeight: TextWeight.medium,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'feedback',
                          child: Row(
                            children: [
                              SharePicture(
                                imagePath: Assets.feedbackIcon,
                                colorFilter: ColorFilter.mode(
                                  ConstColors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text('Feedback'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'report',
                          child: Row(
                            children: [
                              SharePicture(
                                imagePath: Assets.reportIcon,
                                colorFilter: ColorFilter.mode(
                                  ConstColors.red,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Report',
                                style: TextStyle(color: ConstColors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                  icon: SharePicture(
                    imagePath: Assets.moreHrizontal,
                    colorFilter: ColorFilter.mode(
                      ConstColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  spacing: Sizes.s10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsText(
                      text: data.workoutName ?? "unknown",
                      fontSize: Sizes.s20,
                      fontWeight: TextWeight.semiBold,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: ConstColors.orange,
                          size: Sizes.s20,
                        ),
                        PoppinsText(
                          text:
                              "${data.rating ?? 0} (${data.review?.length ?? 0} review)",
                          fontSize: Sizes.s10,
                          fontWeight: TextWeight.regular,
                          color: ConstColors.greyA1A1,
                        ),
                      ],
                    ),
                    Row(
                      spacing: Sizes.s10,
                      children: [
                        CustomChip(
                          text: "For ${data.gender}",
                          color: ConstColors.secondary,
                        ),
                        CustomChip(
                          text: data.levelOf ?? "unknown",
                          color: ConstColors.secondary,
                        ),
                        CustomChip(
                          text: data.workoutType ?? "unknown",
                          color: ConstColors.secondary,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnalsisContainer(
                          iconImage: Assets.runnerIcon,
                          digit:
                              '${data.categorizedVideos?.values.fold(0, (sum, list) => sum + (list.length)) ?? 0}',
                          text: "Exercise",
                        ),
                        AnalsisContainer(
                          iconImage: Assets.chart,
                          digit: data.difficulty ?? "0",
                          text: "Difficulty",
                        ),
                        AnalsisContainer(
                          iconImage: Assets.timeCircle,
                          digit: timeParts["digit"].toString(),
                          text: timeParts["unit"].toString(),
                        ),
                      ],
                    ),
                    PoppinsText(
                      text: "Description",
                      fontSize: Sizes.s16,
                      fontWeight: TextWeight.semiBold,
                    ),

                    ParagraphText(
                      text: data.description.toString(),

                      isExpanded: isExpanded,

                      onTap:
                          () => setState(() {
                            isExpanded = !isExpanded;
                          }),
                    ),

                    PoppinsText(
                      text: "Creator",
                      fontSize: Sizes.s16,
                      fontWeight: TextWeight.semiBold,
                    ),
                    FutureBuilder<UserModel?>(
                      future: UserService().userById(
                        widget.workoutModel.userId!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text("Creator not found"),
                          );
                        }

                        return CreatorListTile(creator: snapshot.data!);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PoppinsText(text: "Price", fontSize: 14),
                  PoppinsText(
                    text: "£ ${data.price!.toDouble().toStringAsFixed(2)}",
                    fontSize: 16,
                    fontWeight: TextWeight.semiBold,
                  ),
                ],
              ),
            ),
            Expanded(flex: 7, child: CustomButton(buttonText: "Buy")),
          ],
        ),
      ),
    );
  }
}
