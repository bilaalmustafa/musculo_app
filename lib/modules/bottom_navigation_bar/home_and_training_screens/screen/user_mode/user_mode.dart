import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/loader/home_loader.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/carasoul_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/item_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/show_bottom_sheet.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/program_video_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/workout_video_items.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UserModeTab extends StatefulWidget {
  const UserModeTab({super.key});

  @override
  State<UserModeTab> createState() => _UserModeTabState();
}

class _UserModeTabState extends State<UserModeTab> {
  // final AuthService _authservces = instance<AuthService>();
  // late UserViewModel authViewModel;
  // Future<UserModel?>? _future;
  @override
  void initState() {
    // _future = context.read<UserViewModel>().getUserById(
    //   _authservces.currentUser!.uid,
    // );
    // authViewModel = context.read<UserViewModel>();
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final usermodeldata = authViewModel.userModel;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),

      child: SingleChildScrollView(
        child: Consumer<UserViewModel>(
          builder: (context, vm, _) {
            final userVm = vm.userModel;
            if (userVm == null) {
              return const HomeLoader();
            }
            return Column(
              spacing: Sizes.s20,
              children: [
                CustomTextField(
                  title: "Search program",
                  // prefexicon: Icons.search,
                  preIcon: Assets.searchIcon,
                  sufIcon: Assets.filterIcon,

                  // suffexicon: Icons.filter_list_outlined,
                ),
                CarasoulContainer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: "Top Programs",
                      fontSize: Sizes.s18,
                      fontWeight: TextWeight.semiBold,
                      color: ConstColors.black,
                    ),
                    PoppinsText(
                      text: "See All",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.medium,
                      color: ConstColors.black,
                    ),
                  ],
                ),
                ItemContainer(),
                // Container(
                //   color: ConstColors.red,
                //   width: double.infinity,
                //   height: 230,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return
                //     },
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: "Your Programs",
                      fontSize: Sizes.s18,
                      fontWeight: TextWeight.semiBold,
                      color: ConstColors.black,
                    ),
                    InkWell(
                      onTap:
                          userVm.listOfPrograms.isNotEmpty
                              ? () {
                                showModalBottomSheet(
                                  backgroundColor: ConstColors.white,
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(32),
                                    ),
                                  ),
                                  builder: (_) {
                                    return ShowBottomSheet(
                                      title: 'Choose Program',
                                      modelData: userVm.listOfPrograms,
                                    );
                                  },
                                );
                              }
                              : null,
                      child: PoppinsText(
                        text: "See All",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.medium,
                        color: ConstColors.black,
                      ),
                    ),
                  ],
                ),
                if (userVm!.listOfPrograms.isEmpty)
                  Center(
                    child: PoppinsText(
                      text: "No Programs ",
                      fontSize: Sizes.s16,
                      color: ConstColors.black.withValues(alpha: 200),
                    ),
                  ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: userVm.listOfPrograms.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:
                      (context, index) => ProgramVideoItem(
                        image: Assets.playbutt,
                        program: userVm.listOfPrograms[index],
                      ),
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: "Your Worouts",
                      fontSize: Sizes.s18,
                      fontWeight: TextWeight.semiBold,
                      color: ConstColors.black,
                    ),
                    InkWell(
                      onTap:
                          userVm.listOfWorkouts.isNotEmpty
                              ? () {
                                showModalBottomSheet(
                                  backgroundColor: ConstColors.white,
                                  context: context,
                                  isScrollControlled: true,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(32),
                                    ),
                                  ),
                                  builder: (_) {
                                    return ShowBottomSheet(
                                      title: 'Choose Workout',
                                      modelData: userVm.listOfWorkouts,
                                    );
                                  },
                                );
                              }
                              : null,
                      child: PoppinsText(
                        text: "See All",
                        fontSize: Sizes.s14,
                        fontWeight: TextWeight.medium,
                        color: ConstColors.black,
                      ),
                    ),
                  ],
                ),
                if (userVm.listOfWorkouts.isEmpty)
                  Center(
                    child: PoppinsText(
                      text: "No Workouts ",
                      fontSize: Sizes.s16,
                      color: ConstColors.black.withValues(alpha: 200),
                    ),
                  ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userVm.listOfWorkouts.length,
                  itemBuilder:
                      (context, index) => WorkoutVideoItem(
                        workouts: userVm.listOfWorkouts[index],
                        image: Assets.playbutt,
                        onChanged: (value) {},
                      ),
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                ),
                SizedBox(height: 5),
              ],
            );
          },
        ),
      ),
    );
  }
}
