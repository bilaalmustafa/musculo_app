import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/modules/auth/register/component/show_dialog_box.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/complete_detail_below.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/confirm_information.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/intervel_time.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/scale_version.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/section_of_workout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/type_of_workout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/warm_up.dart';

class AddWorkoutPageView extends StatefulWidget {
  const AddWorkoutPageView({super.key});

  @override
  State<AddWorkoutPageView> createState() => _AddWorkoutPageViewState();
}

class _AddWorkoutPageViewState extends State<AddWorkoutPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 7 - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      setState(() {}); // Update progress bar
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPage + 1) / 7;
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(progress: progress),

      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          TypeOfWorkout(),
          SectionOfWork(),
          WarmUp(),
          IntervelTime(),
          ScaleVersion(),
          // Work_Out(),
          CompleteDetailBelow(),
          ConfirmInformation(),
        ],

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ).copyWith(bottom: 20),
        child: Row(
          children: [
            Visibility(
              visible: _currentPage + 1 >= 3 && _currentPage + 1 <= 5,

              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PoppinsText(
                            text: " Exercise seleted",
                            fontSize: 11,
                            color: ConstColors.greyA1A1,
                          ),
                          Icon(Icons.arrow_upward_outlined, size: 15),
                        ],
                      ),
                      PoppinsText(
                        text: " 11",
                        fontSize: 14,
                        color: ConstColors.black,
                        fontWeight: TextWeight.semiBold,
                      ),
                    ],
                  ),
                ),
              ), // optional to preserve layout
            ),
            Expanded(
              child: CustomButton(
                buttonText: "Continue",
                onTap: () {
                  if (_currentPage < 7 - 1) {
                    _goToNextPage();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ShowDialogBox(
                          message: "Training created,\ncheck your profile!",
                          bottomWidget: Column(
                            spacing: 10,
                            children: [
                              CustomButton(
                                buttonText: "Create another workout",
                              ),
                              CustomButton(
                                buttonText: "Back to home page",
                                buttonColor: ConstColors.secondary,
                                textColor: ConstColors.black,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
