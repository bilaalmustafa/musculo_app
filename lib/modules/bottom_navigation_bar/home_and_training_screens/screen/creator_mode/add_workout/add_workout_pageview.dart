import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/modules/auth/register/component/show_dialog_box.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/complete_detail_below.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/confirm_information.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/intervel_time.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/level_of_workout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/scale_version.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/section_of_workout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/type_of_workout.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/warm_up.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/routes.dart';

class AddWorkoutPageView extends StatefulWidget {
  const AddWorkoutPageView({super.key});

  @override
  State<AddWorkoutPageView> createState() => _AddWorkoutPageViewState();
}

class _AddWorkoutPageViewState extends State<AddWorkoutPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 8 - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 100),
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

  void _resetWorkoutCreation() {
    // 1. Reset the PageView controller to the first page
    _pageController.jumpToPage(0);

    //    You need to clear all  'clearData'
    context.read<AddWorkoutVeiwModel>().clearData();

    // 3. Close the dialog
    Navigator.of(context).pop();

    // 4. Trigger a rebuild to update the UI (like the progress bar)
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPage + 1) / 8;
    return PopScope(
      canPop: _currentPage == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (_currentPage == 0) {
          context.read<AddWorkoutVeiwModel>().clearData();
        } else {
          _goToPreviousPage();
        }
      },
      child: Scaffold(
        backgroundColor: ConstColors.white,
        appBar: SharedAppBar(
          progress: progress,
          onBackPressed: () {
            if (_currentPage > 0) {
              _goToPreviousPage();
            } else {
              context.read<AddWorkoutVeiwModel>().clearData();
              Navigator.of(context).pop();
            }
          },
        ),

        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            TypeOfWorkout(),
            LevelOfWorkout(),
            SectionOfWork(),
            WarmUp(),
            IntervelTime(),
            ScaleVersion(),

            CompleteDetailBelow(),
            ConfirmInformation(),
          ],

          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),

        bottomNavigationBar: Consumer<AddWorkoutVeiwModel>(
          builder: (context, vm, _) {
            log("vedoess ${vm.selectedVideos.length}");
            log("listss ${vm.selectedList.length}");
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ).copyWith(bottom: 20),
              child: Row(
                children: [
                  Visibility(
                    visible: _currentPage + 1 >= 4 && _currentPage + 1 <= 6,

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
                                SharePicture(imagePath: Assets.arrowUp),
                              ],
                            ),
                            PoppinsText(
                              text:
                                  _currentPage <= 3
                                      ? vm.selectedList.length
                                          .toString()
                                          .padLeft(2, '0')
                                      : vm.selectedVideos.length
                                          .toString()
                                          .padLeft(2, '0'),
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
                      loading: vm.isLoading,
                      buttonText: "Continue",
                      onTap: () async {
                        if (_currentPage < 8 - 1) {
                          switch (_currentPage) {
                            case 0:
                              if (vm.typeofWorkoutvalidate()) {
                                _goToNextPage();
                              }
                            case 1:
                              if (vm.levelofWorkoutvalidate()) {
                                _goToNextPage();
                              }
                            case 2:
                              if (vm.sectionofWorkoutvalidate()) {
                                _goToNextPage();
                              }

                            case 3:
                              if (vm.sectectedvideosvalidation()) {
                                _goToNextPage();
                              }
                            case 6:
                              if (vm.validateAndSaveForm()) {
                                _goToNextPage();
                              }
                            default:
                              _goToNextPage();
                          }
                        } else {
                          final vmUser =
                              context.read<UserViewModel>().userModel!;
                          final userPlan = vmUser.subPlane ?? 'Basic';
                          final workoutCount = await vm.getUserWorkoutCount(
                            vmUser.userId!,
                          );
                          print('Workout .........$workoutCount');

                          if (userPlan == 'Basic' &&
                              workoutCount >= 10 &&
                              context.mounted) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withValues(alpha: 0.9),
                              builder: (context) {
                                return ShowDialogBox(
                                  title: 'Upgrade Required',
                                  message:
                                      "You have reached the limit of 10 workout for Basic creators. Please upgrade to Premium to create more workouts.!",
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

                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          bool success = await vm.creatediscoveryPost(
                            id,
                            vmUser.userId!,
                            vmUser.name!,
                          );

                          if (success && context.mounted) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withValues(alpha: 0.9),
                              builder: (context) {
                                return ShowDialogBox(
                                  message:
                                      "Training created,\ncheck your profile!",
                                  bottomWidget: Column(
                                    spacing: 10,
                                    children: [
                                      CustomButton(
                                        buttonText: "Create another workout",
                                        onTap: () {
                                          _resetWorkoutCreation();
                                        },
                                      ),
                                      SizedBox(height: 5),
                                      CustomButton(
                                        buttonText: "Back to home page",
                                        buttonColor: ConstColors.secondary,
                                        textColor: ConstColors.black,
                                        onTap: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.bottomnavigationbarscreen,
                                            (Route<dynamic> route) => false,
                                            arguments: {
                                              'initialMainTabIndex':
                                                  0, // <--- Tell BottomNav to go to Home tab (index 0)
                                              'initialHomeScreenSubTab':
                                                  1, // <--- Tell Home Screen to go to Creator Mode tab (index 1)
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
                              msg: "Failed to post workout. Please try again.",
                              backgroundColor: Colors.red,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
