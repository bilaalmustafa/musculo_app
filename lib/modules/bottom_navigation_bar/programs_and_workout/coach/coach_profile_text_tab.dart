import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/paragraph_text.dart';
import 'package:provider/provider.dart';

import '../../home_and_training_screens/view_model/user_view_model.dart';

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
    final creatorVm = context.read<UserViewModel>();
    final data = creatorVm.userModel;
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
                text: data?.overviewText ?? "",
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
                text: data?.experienceText ?? "",
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
                text: data?.goalText ?? "",

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
