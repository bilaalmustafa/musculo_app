import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/shared_appbar.dart';

import 'package:musculo_app/modules/auth/register/screens/age_screen.dart';
import 'package:musculo_app/modules/auth/register/screens/agreement_screen.dart';
import 'package:musculo_app/modules/auth/register/screens/fitness_level_screen.dart';

import 'package:musculo_app/modules/auth/register/screens/gender_screen.dart';
import 'package:musculo_app/modules/auth/register/screens/name_Screen.dart';
import 'package:musculo_app/modules/auth/register/screens/sign_up_screen.dart';
import 'package:musculo_app/modules/auth/register/component/show_dialog_box.dart';

import '../../../../core/constants/assets.dart';

class RegisterScren extends StatefulWidget {
  const RegisterScren({super.key});

  @override
  State<RegisterScren> createState() => _RegisterScrenState();
}

class _RegisterScrenState extends State<RegisterScren> {
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPage + 1) / 6;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(progress: progress),

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },

        children: [
          NameScreen(),
          GenderScreen(),
          AgeScreen(),
          FitnessLevelScren(),
          SignUpScreen(),
          AgreementScreen(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: CustomButton(
          buttonText: "Continue",
          onTap: () {
            if (_currentPage < 6 - 1) {
              _goToNextPage();
            } else {
              showDialog(
                context: context,
                barrierColor: Colors.black.withValues(alpha: 0.9),
                builder: (BuildContext context) {
                  return ShowDialogBox(
                    message:
                        "Your account is ready to use. You will be redirected to the home page in a few seconds.",
                    bottomWidget: Image(image: AssetImage(Assets.vector)),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
