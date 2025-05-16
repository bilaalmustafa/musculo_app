import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/paragraph_text.dart';

class CoachProfileTextScreen extends StatefulWidget {
  const CoachProfileTextScreen({super.key});

  @override
  State<CoachProfileTextScreen> createState() => _CoachProfileTextScreenState();
}

class _CoachProfileTextScreenState extends State<CoachProfileTextScreen> {
  bool overisExpanded = false;
  bool expisExpanded = false;
  bool goalisExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: Sizes.s10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsText(
                text: "Overview",
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              ),
              ParagraphText(
                text:
                    "This is a long paragraph. It spans many lines. "
                    "We only want to show a few lines and then let the user tap View More. "
                    "This helps keep the UI clean and readable for longer content.This is a long paragraph. It spans many lines. "
                    "We only want to show a few lines and then let the user tap View More. "
                    "This helps keep the UI clean and readable for longer content.",
                isExpanded: overisExpanded,
                onTap:
                    () => setState(() {
                      overisExpanded = !overisExpanded;
                    }),
              ),
              PoppinsText(
                text: "Expereince",
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              ),
              ParagraphText(
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore",
                isExpanded: expisExpanded,
                onTap:
                    () => setState(() {
                      expisExpanded = !expisExpanded;
                    }),
              ),
              PoppinsText(
                text: "Goal",
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              ),
              ParagraphText(
                text:
                    "This is a long paragraph. It spans many lines. "
                    "We only want to show a few lines and then let the user tap View More. "
                    "This helps keep the UI clean and readable for longer content.This is a long paragraph. It spans many lines. "
                    "We only want to show a few lines and then let the user tap View More. "
                    "This helps keep the UI clean and readable for longer content.",
                isExpanded: goalisExpanded,
                onTap:
                    () => setState(() {
                      goalisExpanded = !goalisExpanded;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
