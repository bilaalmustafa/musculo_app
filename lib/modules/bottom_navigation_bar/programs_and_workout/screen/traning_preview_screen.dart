import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/analysis_containers.dart';

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
              ),

              Positioned(
                top: context.screenheight * .07,
                left: 20,
                child: Icon(Icons.arrow_back_ios, color: ConstColors.white),
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
                    print(value);
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: ConstColors.black,
                              ),
                              Text('  Like workout'),
                            ],
                          ),
                        ),
                      ],
                  icon: Icon(Icons.more_vert, color: Colors.white),
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
                          icon: Icons.run_circle_outlined,
                          digit: "15",
                          text: "Exercise",
                        ),
                        AnalsisContainer(
                          icon: Icons.analytics_outlined,
                          digit: "7",
                          text: "Difficulty",
                        ),
                        AnalsisContainer(
                          icon: Icons.timelapse_outlined,
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
