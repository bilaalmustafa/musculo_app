import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/modules/auth/register/screens/age_screen.dart';
import 'package:musculo_app/modules/auth/register/screens/agreement_screen.dart';
import 'package:musculo_app/modules/auth/register/screens/fitness_level_screen.dart';

import 'package:musculo_app/modules/auth/register/screens/gender_screen.dart';
import 'package:musculo_app/modules/auth/register/screens/name_Screen.dart';
import 'package:musculo_app/modules/auth/register/screens/sign_up_screen.dart';
import 'package:musculo_app/modules/auth/register/component/show_dialog_box.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<AuthViewModel>(
          builder: (context, vm, _) {
            return CustomButton(
              loading: vm.isLoading,
              buttonText: "Continue",
              onTap: () async {
                if (_currentPage == 0) {
                  if (vm.validateAndSaveForm()) {
                    _goToNextPage();
                  } else {
                    return;
                  }
                } else if (_currentPage == 4) {
                  if (vm.validateAndSaveForm()) {
                    _goToNextPage();
                  } else {
                    return;
                  }
                } else if (_currentPage < 6 - 1) {
                  _goToNextPage();
                } else {
                  User? user = await context.read<AuthViewModel>().signUp();
                  if (user != null && context.mounted) {
                    showDialog(
                      barrierDismissible: true,
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
                    await Future.delayed(Duration(seconds: 5), () {
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.bottomnavigationbarscreen,
                         
                          (route) => false,
                        );
                      }
                    });
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
