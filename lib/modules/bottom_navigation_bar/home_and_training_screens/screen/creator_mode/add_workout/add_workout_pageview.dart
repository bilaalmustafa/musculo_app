import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
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
    if (_currentPage < 6 - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {}); // Update progress bar
    }
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPage + 1) / 6;
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(progress: progress),

      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [TypeOfWorkout(), SectionOfWork(), WarmUp()],

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ).copyWith(bottom: 20),
        child: CustomButton(
          buttonText: "Continue",
          onTap: () {
            if (_currentPage < 6 - 1) {
              _goToNextPage();
            } else {}
          },
        ),
      ),
    );
  }
}
