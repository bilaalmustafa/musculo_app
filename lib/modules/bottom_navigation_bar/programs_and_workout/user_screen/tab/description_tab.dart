import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/analysis_containers.dart';

class DescriptionTab extends StatefulWidget {
  const DescriptionTab({super.key});

  @override
  State<DescriptionTab> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<DescriptionTab> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: Sizes.s10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(
                    text: "Power Lift",
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

                  PoppinsText(
                    text: "Description",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This is a long paragraph. It spans many lines. "
                        "We only want to show a few lines and then let the user tap View More. "
                        "This helps keep the UI clean and readable for longer content.This is a long paragraph. It spans many lines. "
                        "We only want to show a few lines and then let the user tap View More. "
                        "This helps keep the UI clean and readable for longer content.",
                        maxLines: isExpanded ? null : 5,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 13),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            isExpanded ? "View Less" : "View More...",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  PoppinsText(
                    text: "Creator",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),
                  CreatorListTile(),
                  PoppinsText(
                    text: "Workouts ",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnalsisContainer(
                        iconImage: Assets.timeCircle,
                        digit: "10",
                        text: "Weeks",
                      ),
                      AnalsisContainer(
                        iconImage: Assets.runnerIcon,
                        digit: "15",
                        text: "Workout",
                      ),
                      AnalsisContainer(
                        iconImage: Assets.chart,
                        digit: "3X",
                        text: "week",
                      ),
                    ],
                  ),
                  SizedBox(height: Sizes.s20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: 20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(text: "Price", fontSize: 13),
                  PoppinsText(
                    text: "£20.00",
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
