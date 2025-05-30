import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/analysis_containers.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/paragraph_text.dart';

import '../../../../core/config/routes.dart';

class TraningPreviewScreen extends StatefulWidget {
  const TraningPreviewScreen({super.key});

  @override
  State<TraningPreviewScreen> createState() => _TraningPreviewScreenState();
}

class _TraningPreviewScreenState extends State<TraningPreviewScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
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
                    if (value == 'like') {
                      // navigate to favirate screen
                    }

                    if (value == "feedback") {
                      Navigator.pushNamed(
                        context,
                        Routes.feedbScreen,
                        arguments: {'feedbackType': 'WorkOut'},
                      );
                    }
                    if (value == "report") {
                      Navigator.pushNamed(
                        context,
                        Routes.reportScreen,
                        arguments: {'reportType': 'Report workOut'},
                      );
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'Like',
                          child: Row(
                            children: [
                              SharePicture(imagePath: Assets.heartIcon),
                              SizedBox(width: Sizes.s8),
                              PoppinsText(
                                text: 'Like Workout',
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
                      text: "Belly Fat Burning",
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
                          text: "4.6 (54 review)",
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
                          text: "For Males",
                          color: ConstColors.secondary,
                        ),
                        CustomChip(
                          text: "Beginner",
                          color: ConstColors.secondary,
                        ),
                        CustomChip(
                          text: "With equipment",
                          color: ConstColors.secondary,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnalsisContainer(
                          iconImage: Assets.runnerIcon,
                          digit: "15",
                          text: "Exercise",
                        ),
                        AnalsisContainer(
                          iconImage: Assets.chart,
                          digit: "7",
                          text: "Difficulty",
                        ),
                        AnalsisContainer(
                          iconImage: Assets.timeCircle,
                          digit: "10",
                          text: "Munites",
                        ),
                      ],
                    ),
                    PoppinsText(
                      text: "Description",
                      fontSize: Sizes.s16,
                      fontWeight: TextWeight.semiBold,
                    ),

                    ParagraphText(
                      text:
                          "This is a long paragraph. It spans many lines. "
                          "We only want to show a few lines and then let the user tap View More. "
                          "This helps keep the UI clean and readable for longer content.This is a long paragraph. It spans many lines. "
                          "We only want to show a few lines and then let the user tap View More. "
                          "This helps keep the UI clean and readable for longer content.",
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
                    CreatorListTile(),
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
                    text: "£5.00",
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
