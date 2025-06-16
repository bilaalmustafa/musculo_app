import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/auth/register/component/show_dialog_box.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/add_indended.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/add_program_name.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/add_your_program.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/days_a_week_from_calender.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/days_a_weeks.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/duration_of_program.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/level_of_program.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/type_of_program.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_program/view_model/add_program_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/routes.dart';

class AddProgramPageview extends StatefulWidget {
  const AddProgramPageview({super.key});

  @override
  State<AddProgramPageview> createState() => _AddProgramPageviewState();
}

class _AddProgramPageviewState extends State<AddProgramPageview> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 8 - 1) {
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
    double progress = (_currentPage + 1) / 8;
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
          DaysAWeeksFromCalender(),
          AddYourProgram(),
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
        child: Row(
          spacing: 10,
          children: [
            Visibility(
              visible: _currentPage + 1 == 8,

              child: Expanded(
                child: CustomButton(
                  textColor: ConstColors.black,
                  buttonColor: ConstColors.secondary,
                  buttonText: "Add Later",
                  onTap: () {},
                ),
              ), // optional to preserve layout
            ),

            Expanded(
              child: Consumer<AddProgramViewModel>(
                builder: (context, vm, _) {
                  return CustomButton(
                    loading: vm.isLoading,
                    buttonText: "Continue",
                    onTap: () async {
                      if (_currentPage < 8 - 1) {
                        switch (_currentPage) {
                          case 0:
                            if (vm.validateAndSaveForm()) {
                              _goToNextPage();
                            }
                            break;
                          case 1:
                            if (vm.intededvalidate()) {
                              _goToNextPage();
                            }
                            break;
                          case 2:
                            if (vm.typeofProgramvalidate()) {
                              _goToNextPage();
                            }
                            break;
                          case 3:
                            if (vm.levelofProgramsvalidate()) {
                              _goToNextPage();
                            }
                          
                            break;
                          default:
                            _goToNextPage();
                        }
                      } else {
                        if (vm.sectectedworksvalidation()) {
                          final userVm =
                              context.read<UserViewModel>().userModel!;

                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          bool success = await vm.creatediscoveryPost(
                            id,
                            userVm.userId!,
                            userVm.name!,
                          );

                          log("Success: ${success.toString()}");

                          if (success && context.mounted) {
                            Fluttertoast.showToast(
                              msg: "Program Posted Successfully!",
                            );

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return ShowDialogBox(
                                  message: "Your program is live!",
                                  bottomWidget: Column(
                                    spacing: 10,
                                    children: [
                                      CustomButton(
                                        buttonText: "Create another program",
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushNamed(
                                            context,
                                            Routes.addprogrampageview,
                                          );
                                          // Navigator.pushNamedAndRemoveUntil(
                                          //   context,
                                          //   Routes.addprogrampageview,
                                          //   (route) => false,
                                          // );
                                          setState(() {
                                            _currentPage = 0;
                                          });
                                        },
                                      ),
                                      CustomButton(
                                        buttonText: "Back to home page",
                                        buttonColor: ConstColors.secondary,
                                        textColor: ConstColors.black,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.bottomnavigationbarscreen,
                                            (route) => false,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (context.mounted) {
                            Fluttertoast.showToast(
                              msg: "Failed to post program. Please try again.",
                              backgroundColor: Colors.red,
                            );
                          }
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
