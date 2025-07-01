import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/paragraph_text.dart';

class CoachProfileTextScreen extends StatefulWidget {
  final UserModel creator;
  const CoachProfileTextScreen({super.key, required this.creator});

  @override
  State<CoachProfileTextScreen> createState() => _CoachProfileTextScreenState();
}

class _CoachProfileTextScreenState extends State<CoachProfileTextScreen> {
  bool overisExpanded = false;
  bool expisExpanded = false;
  bool goalisExpanded = false;
  @override
  Widget build(BuildContext context) {
    final creator = widget.creator;
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
                text: creator.overviewText ?? "",
                isExpanded: overisExpanded,
                onTap:
                    () => setState(() {
                      overisExpanded = !overisExpanded;
                    }),
              ),
              PoppinsText(
                text: "Experience",
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              ),
              ParagraphText(
                text: creator.experienceText ?? "",
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
                text: creator.goalText ?? "",

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
