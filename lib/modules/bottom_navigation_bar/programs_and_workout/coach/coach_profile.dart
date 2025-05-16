import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/components/tab_buttons.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/coach/coach_profile_text_tab.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/coach/program/workouts_tab.dart';

class CoachProfile extends StatefulWidget {
  const CoachProfile({super.key});

  @override
  State<CoachProfile> createState() => _CoachProfileState();
}

class _CoachProfileState extends State<CoachProfile> {
  int selectTab = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(actionIcon: Icons.more_horiz_outlined),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              //color: ConstColors.amber,
              image: DecorationImage(
                image: AssetImage(Assets.profilebgpng),
                fit: BoxFit.contain,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage(Assets.workout),
                ),
                SizedBox(height: Sizes.s10),
                PoppinsText(
                  text: "Coach name",
                  fontSize: Sizes.s20,
                  fontWeight: TextWeight.semiBold,
                ),
                Row(
                  spacing: Sizes.s10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: ConstColors.orange, size: 20),
                    PoppinsText(text: "4.6 |", fontSize: Sizes.s10),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ConstColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 18),
                          PoppinsText(
                            text: "Premium Creator",
                            fontSize: Sizes.s10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TabButtons(
              selecttab: selectTab,

              tabNames: ["Description", "Programs/Workouts"],
              onChange:
                  (index) => setState(() {
                    selectTab = index;

                    _pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                  }),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [CoachProfileTextScreen(), ProgramWorkOutsTab()],
            ),
          ),
        ],
      ),
    );
  }
}
