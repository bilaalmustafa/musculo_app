import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/shared_appbar.dart';

import 'package:musculo_app/core/constants/const_colors.dart';

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
  final int initialIndex;
  final String? programId;
  final bool shouldPopToHome;
  const AddProgramPageview({
    super.key,
    this.initialIndex = 0,
    this.programId,
    this.shouldPopToHome = false,
  });

  @override
  State<AddProgramPageview> createState() => _AddProgramPageviewState();
}

class _AddProgramPageviewState extends State<AddProgramPageview> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex); // 👈
    _currentPage = widget.initialIndex;

    if (widget.programId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AddProgramViewModel>().loadProgramForEditing(
          widget.programId!,
        );
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      setState(() {}); // Update progress bar
    }
  }

  void _resetProgramCreation() {
    // 1. Reset the PageView controller to the first page
    _pageController.jumpToPage(0);

    //    You need to clear all  'clearData'
    context.read<AddProgramViewModel>().clearData();

    // 3. Close the dialog
    Navigator.of(context).pop();

    // 4. Trigger a rebuild to update the UI (like the progress bar)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPage + 1) / 8;
    return PopScope(
      canPop: _currentPage == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (widget.shouldPopToHome) {
            context.read<AddProgramViewModel>().clearData();
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (_currentPage > 0) {
            _goToPreviousPage();
          } else {
            context.read<AddProgramViewModel>().clearData();
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: ConstColors.white,
        appBar: SharedAppBar(
          progress: progress,
          onBackPressed: () {
            if (widget.shouldPopToHome) {
              context.read<AddProgramViewModel>().clearData();
              Navigator.of(context).popUntil((route) => route.isFirst);
            } else if (_currentPage > 0) {
              _goToPreviousPage();
            } else {
              context.read<AddProgramViewModel>().clearData();
              Navigator.of(context).pop();
            }
          },
        ),

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
                  child: Consumer<AddProgramViewModel>(
                    builder: (context, vm, _) {
                      return CustomButton(
                        loading: vm.isAddLaterLoading,
                        loadingColor: ConstColors.black,
                        textColor: ConstColors.black,
                        buttonColor: ConstColors.secondary,
                        buttonText: "Add Later",
                        onTap: () async {
                          vm.setAddLaterLoading(true);
                          final uservm =
                              context.read<UserViewModel>().userModel!;
                          final userPlan = uservm.subPlane ?? 'Basic';

                          // check plan limit
                          final programCount = await vm.getUserProgramCount(
                            uservm.userId!,
                          );

                          if (userPlan == 'Basic' &&
                              programCount >= 10 &&
                              context.mounted) {
                            vm.setAddLaterLoading(false);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withValues(alpha: 0.9),
                              builder: (context) {
                                return ShowDialogBox(
                                  title: 'Upgrade Required',
                                  message:
                                      "You have reached the limit of 10 programs for Basic creators. Please upgrade to Premium to create more programs.!",
                                  bottomWidget: Column(
                                    spacing: 10,
                                    children: [
                                      CustomButton(
                                        buttonText: "Back to home page",
                                        buttonColor: ConstColors.secondary,
                                        textColor: ConstColors.black,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.bottomnavigationbarscreen,
                                            (Route<dynamic> route) => false,
                                            arguments: {
                                              'initialMainTabIndex': 0,
                                              'initialHomeScreenSubTab': 1,
                                            },
                                          );
                                        },
                                      ),

                                      CustomButton(
                                        buttonText: "Upgrade Plan",
                                        onTap: () {
                                          // _resetProgramCreation();
                                          Navigator.pushNamed(
                                            context,
                                            Routes.becomeCreatorScreen,
                                            arguments: {
                                              'fromUpgradePopup': true,
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            return;
                          }

                          bool success = await vm.creatediscoveryPost(
                            uservm.userId!,
                            uservm.name!,
                            addLater: true,
                          );
                          vm.setAddLaterLoading(false);
                          if (success && context.mounted) {
                            Fluttertoast.showToast(
                              msg:
                                  "Program saved as draft. Add workouts later!",
                            );

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.bottomnavigationbarscreen,
                              (route) => false,
                              arguments: {
                                'initialMainTabIndex': 0,
                                'initialHomeScreenSubTab': 1,
                              },
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Failed to save program. Please try again.",
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),

              Expanded(
                child: Consumer<AddProgramViewModel>(
                  builder: (context, vm, _) {
                    return CustomButton(
                      loading: vm.isContinueLoading,
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
                            case 4:
                              if (vm.validateAddDuratuon() &&
                                  vm.validateAndSaveForm()) {
                                _goToNextPage();
                              }
                            case 5:
                              if (vm.validateofSeletedTime()) {
                                _goToNextPage();
                              }
                            case 6:
                              if (vm.validateofSeleteddays()) {
                                _goToNextPage();
                              }
                              break;
                            default:
                              _goToNextPage();
                          }
                        } else {
                          if (vm.sectectedworksvalidation()) {
                            vm.setContinueLoading(true);
                            final userVm =
                                context.read<UserViewModel>().userModel!;
                            final userPlan = userVm.subPlane ?? 'Basic';
                            final programCount = await vm.getUserProgramCount(
                              userVm.userId!,
                            );
                            print('Program .........$programCount');

                            if (userPlan == 'Basic' &&
                                programCount >= 10 &&
                                context.mounted) {
                              vm.setContinueLoading(false);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: Colors.black.withValues(
                                  alpha: 0.9,
                                ),
                                builder: (context) {
                                  return ShowDialogBox(
                                    title: 'Upgrade Required',
                                    message:
                                        "You have reached the limit of 10 programs for Basic creators. Please upgrade to Premium to create more programs.!",
                                    bottomWidget: Column(
                                      spacing: 10,
                                      children: [
                                        CustomButton(
                                          buttonText: "Back to home page",
                                          buttonColor: ConstColors.secondary,
                                          textColor: ConstColors.black,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Routes.bottomnavigationbarscreen,
                                              (Route<dynamic> route) => false,
                                              arguments: {
                                                'initialMainTabIndex': 0,
                                                'initialHomeScreenSubTab': 1,
                                              },
                                            );
                                          },
                                        ),

                                        CustomButton(
                                          buttonText: "Upgrade Plan",
                                          onTap: () {
                                            // _resetProgramCreation();
                                            Navigator.pushNamed(
                                              context,
                                              Routes.becomeCreatorScreen,
                                              arguments: {
                                                'fromUpgradePopup': true,
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              return; // stop further processing
                            }

                            bool success = await vm.creatediscoveryPost(
                              userVm.userId!,
                              userVm.name!,
                            );

                            log("Success: ${success.toString()}");
                            vm.setContinueLoading(false);
                            if (success && context.mounted) {
                              Fluttertoast.showToast(
                                msg: "Program Posted Successfully!",
                              );

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: Colors.black.withValues(
                                  alpha: 0.9,
                                ),
                                builder: (context) {
                                  return ShowDialogBox(
                                    message: "Your program is live!",
                                    bottomWidget: Column(
                                      spacing: 10,
                                      children: [
                                        CustomButton(
                                          buttonText: "Create another program",
                                          onTap: () {
                                            _resetProgramCreation();
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
                                              (Route<dynamic> route) => false,
                                              arguments: {
                                                'initialMainTabIndex': 0,
                                                'initialHomeScreenSubTab': 1,
                                              },
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
                                msg:
                                    "Failed to post program. Please try again.",
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
      ),
    );
  }
}
