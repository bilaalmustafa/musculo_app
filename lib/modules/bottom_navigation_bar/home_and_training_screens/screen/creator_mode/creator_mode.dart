import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creatorworkoutsprogram.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/analysis_listtile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/creator_List_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/creatorworkoutlist.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/day_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';

import 'package:provider/provider.dart';

import '../../../../../core/constants/assets.dart';

class CreatorModeTab extends StatefulWidget {
  const CreatorModeTab({super.key});

  @override
  State<CreatorModeTab> createState() => _CreatorModeTabState();
}

class _CreatorModeTabState extends State<CreatorModeTab> {
  int selectTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Consumer<UserViewModel>(
        builder: (context, vm, _) {
          final creatorVm = vm.userModel;

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: Sizes.s150,
                color: ConstColors.black,

                child: Column(
                  spacing: Sizes.s10,

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PoppinsText(
                      text: "\$${vm.getBalance(creatorVm).toStringAsFixed(2)}",
                      fontSize: Sizes.s30,
                      color: ConstColors.white,
                      fontWeight: TextWeight.semiBold,
                    ),
                    PoppinsText(
                      text: "Balance Available",
                      fontSize: Sizes.s10,
                      color: ConstColors.white,
                      fontWeight: TextWeight.regular,
                    ),
                    DaysChip(
                      daylist: ["1D", "1W", "1M", "3M", "1Y"],
                      selectTab: selectTab,
                      onTap: (index) {
                        setState(() {
                          selectTab = index;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AnalysisLisTile(
                            heading1: "Total sales",
                            heading2: creatorVm?.sold.length.toString() ?? "0",
                            iconImage: Assets.chartBlack,
                          ),
                          AnalysisLisTile(
                            heading1: "Cancelled",
                            heading2: vm.cancelCount(creatorVm).toString(),
                            iconImage: Assets.closeSquare,
                            iconColor: ColorFilter.mode(
                              ConstColors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnalysisLisTile(
                            heading1: "Ratings",
                            heading2: "${creatorVm?.rating ?? 0.0}",
                            iconImage: Assets.star1,
                          ),

                          AnalysisLisTile(
                            heading1: "Withdrawed",
                            heading2: "\$${creatorVm?.withdraw ?? 0.0}",
                            iconImage: Assets.upload1,
                          ),
                        ],
                      ),

                      SizedBox(height: Sizes.s20),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ).copyWith(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PoppinsText(
                              text: "Your Programs",
                              fontSize: Sizes.s20,
                              fontWeight: TextWeight.semiBold,
                              color: ConstColors.black,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(
                                  context: context,
                                  title: 'Your Programs',

                                  child:
                                      CreatorWorkoutsProgramList<ProgramModel>(
                                        stream: vm.getProgamOfCreatoe(
                                          creatorVm?.userId ?? "",
                                        ),
                                        itemBuilder:
                                            (program) => CreatorListItems(
                                              programModel: program,
                                            ),
                                        emptyMessage: "No Programs",
                                      ),
                                );
                              },

                              child: PoppinsText(
                                text: "See All",
                                fontSize: Sizes.s14,
                                fontWeight: TextWeight.semiBold,
                                color: ConstColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: CreatorWorkoutsProgramList<ProgramModel>(
                          stream: vm.getProgamOfCreatoe(
                            creatorVm?.userId ?? '',
                          ),
                          itemBuilder:
                              (program) =>
                                  CreatorListItems(programModel: program),
                          emptyMessage: 'No Programs',
                        ),
                      ),
                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ).copyWith(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PoppinsText(
                              text: "Your Workouts",
                              fontSize: Sizes.s20,
                              fontWeight: TextWeight.semiBold,
                              color: ConstColors.black,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(
                                  context: context,
                                  title: 'Your Workouts',
                                  child:
                                      CreatorWorkoutsProgramList<WorkoutModel>(
                                        stream: vm.getWorkOutOfCreator(
                                          creatorVm?.userId ?? "",
                                        ),
                                        itemBuilder:
                                            (workout) => CreatorWorkoutList(
                                              workoutModel: workout,
                                            ),
                                        emptyMessage: "No Workouts",
                                      ),
                                );
                              },

                              child: PoppinsText(
                                text: "See All",
                                fontSize: Sizes.s14,
                                fontWeight: TextWeight.semiBold,
                                color: ConstColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: CreatorWorkoutsProgramList<WorkoutModel>(
                            stream: vm.getWorkOutOfCreator(
                              creatorVm?.userId ?? '',
                            ),
                            itemBuilder:
                                (workout) =>
                                    CreatorWorkoutList(workoutModel: workout),
                            emptyMessage: 'No Workouts',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showBottomSheet({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ConstColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder:
          (_) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.60,
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  height: Sizes.s4,
                  width: Sizes.s50,
                  color: ConstColors.greyb3b3,
                ),
                const SizedBox(height: 10),
                PoppinsText(
                  text: title,
                  fontSize: Sizes.s20,
                  fontWeight: TextWeight.semiBold,
                  color: ConstColors.black,
                ),
                const SizedBox(height: 10),
                Divider(
                  color: ConstColors.secondary,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 10),
                Expanded(child: child),
                SizedBox(height: 10),
              ],
            ),
          ),
    );
  }
}
