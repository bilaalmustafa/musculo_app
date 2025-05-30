import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/model/user_model.dart';
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
  final AuthService _authservces = instance<AuthService>();

  Future<UserModel?>? _Future;
  @override
  void initState() {
    _Future = context.read<UserViewModel>().getUserById(
      _authservces.currentUser!.uid,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),

      child: SingleChildScrollView(
        child: Column(
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
            FutureBuilder<UserModel?>(
              future: _Future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: PoppinsText(
                      text: "No Programs Found",
                      fontSize: Sizes.s16,
                      color: ConstColors.red,
                    ),
                  );
                }

                // final data = snapshot.data!.data() as Map<String, dynamic>;
                final UserModel userModel = snapshot.data!;
                if (userModel.listOfPrograms.isEmpty) {
                  return Center(
                    child: PoppinsText(
                      text: "No Programs",
                      fontSize: Sizes.s16,
                      color: ConstColors.red,
                    ),
                  );
                }
                return Column(
                  spacing: Sizes.s10,
                  children: [
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
                          onTap: () {
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
                                  modelData: userModel.listOfPrograms,
                                );
                              },
                            );
                          },
                          child: PoppinsText(
                            text: "See All",
                            fontSize: Sizes.s14,
                            fontWeight: TextWeight.medium,
                            color: ConstColors.black,
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: userModel.listOfPrograms.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (context, index) => ProgramVideoItem(
                            image: Assets.playbutt,
                            program: userModel.listOfPrograms[index],
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 20),
                    ),
                  ],
                );
              },
            ),

            FutureBuilder<UserModel?>(
              future: _Future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: PoppinsText(
                      text: "No Workouts Found",
                      fontSize: Sizes.s16,
                      color: ConstColors.red,
                    ),
                  );
                }

                // final data = snapshot.data!.data() as Map<String, dynamic>;
                final UserModel userModel = snapshot.data!;
                if (userModel.listOfWorkouts.isEmpty) {
                  return Center(
                    child: PoppinsText(
                      text: "No Workouts",
                      fontSize: Sizes.s16,
                      color: ConstColors.red,
                    ),
                  );
                }
                return Column(
                  spacing: Sizes.s10,
                  children: [
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
                          onTap: () {
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
                                  modelData: userModel.listOfWorkouts,
                                );
                              },
                            );
                          },
                          child: PoppinsText(
                            text: "See All",
                            fontSize: Sizes.s14,
                            fontWeight: TextWeight.medium,
                            color: ConstColors.black,
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: userModel.listOfWorkouts.length,
                      itemBuilder:
                          (context, index) => WorkoutVideoItem(
                            workoutModel: userModel.listOfWorkouts[index],
                            image: Assets.playbutt,
                            onChanged: (value) {},
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 20),
                    ),
                    SizedBox(height: 5),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
