import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/add_indended.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/add_program_name.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/days_a_weeks.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/duration_of_program.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/level_of_program.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/type_of_program.dart';

class AddProgramPageview extends StatefulWidget {
  const AddProgramPageview({super.key});

  @override
  State<AddProgramPageview> createState() => _AddProgramPageviewState();
}

class _AddProgramPageviewState extends State<AddProgramPageview> {
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
        children: [
          AddProgramName(),
          AddIndended(),
          TypeOfProgram(),
          LevelOfProgram(),
          DurationOfProgram(),
          DaysAWeeks(),
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
