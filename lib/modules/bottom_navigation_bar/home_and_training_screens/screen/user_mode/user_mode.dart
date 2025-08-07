import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/loader/home_loader.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/routes.dart';

import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/exercise_services.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/carasoul_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/item_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/show_bottom_sheet.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/program_video_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/workout_video_items.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/injections.dart';
import '../../../../../model/programs_model.dart';
import '../../../programs_and_workout/component/program_item_dis.dart';
import 'program_search_screen.dart';

class UserModeTab extends StatefulWidget {
  const UserModeTab({super.key});

  @override
  State<UserModeTab> createState() => _UserModeTabState();
}

class _UserModeTabState extends State<UserModeTab> {
  Stream<List<ProgramModel>>? stream;
  final TextEditingController _searchController = TextEditingController();

  FocusNode _homeFocusNode = FocusNode();
  // final AuthService _authservces = instance<AuthService>();
  // late UserViewModel authViewModel;
  // Future<UserModel?>? _future;
  @override
  void initState() {
    // _future = context.read<UserViewModel>().getUserById(
    //   _authservces.currentUser!.uid,
    // );
    // authViewModel = context.read<UserViewModel>();

    stream = instance<ProgramServices>().getPrograms();
    _homeFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _homeFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<ProgramModel> _topTenPrograms = [];
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
                  controller: _searchController,
                  title: "Search program",
                  // prefexicon: Icons.search,
                  preIcon: Assets.searchIcon,
                  sufIcon: Assets.filterIcon,
                  readOnly: true,
                  focusNode: _homeFocusNode,
                  onclick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ProgramSearchScreen(
                              controller: _searchController,
                            ),
                      ),
                    );

                    _homeFocusNode.unfocus();
                  },
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
                    GestureDetector(
                      onTap: () {
                        // TODO: here we add BottomSheet of top ten Programs;

                        showModalBottomSheet(
                          context: context,
                          backgroundColor: ConstColors.secondary,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          builder:
                              (_) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.71,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    Container(
                                      height: Sizes.s4,
                                      width: Sizes.s50,
                                      decoration: BoxDecoration(
                                        color: ConstColors.greyb3b3,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    PoppinsText(
                                      text: "Top Programs",
                                      fontSize: Sizes.s18,
                                      fontWeight: TextWeight.semiBold,
                                      color: ConstColors.black,
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(
                                      color: ConstColors.greyE6EA,
                                      thickness: 2,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: _topTenPrograms.length,
                                        itemBuilder: (context, index) {
                                          final program =
                                              _topTenPrograms[index];
                                          return ProgramItemDis(
                                            program: program,
                                          );

                                          // ItemContainer(
                                          //   program: program,
                                          // );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                SizedBox(
                  height: Sizes.s180,
                  child: StreamBuilder<List<ProgramModel>>(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CustomShimmer(height: 150));
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: PoppinsText(
                            text: "An error occurred: ${snapshot.error}",
                            fontSize: Sizes.s16,
                            color: ConstColors.black,
                          ),
                        );
                      }

                      final programs = snapshot.data ?? [];
                      // print('here we print programs ${programs.length}');

                      //  Sort programs by rating (highest first)
                      programs.sort(
                        (a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0),
                      );

                      if (programs.isEmpty) {
                        return Center(
                          child: PoppinsText(
                            text: "No Programs",
                            fontSize: Sizes.s16,
                            color: ConstColors.black,
                          ),
                        );
                      }

                      _topTenPrograms = programs.take(10).toList();

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _topTenPrograms.length,
                        itemBuilder: (context, index) {
                          final program = _topTenPrograms[index];

                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 0 : 8, // more space at start
                              right:
                                  index == _topTenPrograms.length - 1
                                      ? 0
                                      : 8, // more space at end
                            ),
                            child: ItemContainer(program: program),
                          );
                        },
                      );
                    },
                  ),
                ),

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
                                      usermodel: userVm,
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
                if (userVm.listOfPrograms.isEmpty)
                  Center(
                    child: PoppinsText(
                      text: "No Programs ",
                      fontSize: Sizes.s16,
                      color: ConstColors.black.withValues(alpha: 200),
                    ),
                  ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount:
                      userVm.listOfPrograms.length >= 3
                          ? 3
                          : userVm.listOfPrograms.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:
                      (context, index) => ProgramVideoItem(
                        image: Assets.playbutt,
                        program: userVm.listOfPrograms[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.trainingscreen,

                            arguments: {
                              'workoutData': userVm.listOfPrograms[index],
                              'userModel': userVm, // UserModel
                            },
                          );
                        },
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
                                      usermodel: userVm,
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
                  itemCount:
                      userVm.listOfWorkouts.length >= 3
                          ? 3
                          : userVm.listOfWorkouts.length,
                  itemBuilder:
                      (context, index) => WorkoutVideoItem(
                        workouts: userVm.listOfWorkouts[index],
                        image: Assets.playbutt,
                        onChanged: (value) {},
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.trainingscreen,

                            arguments: {
                              'workoutData':
                                  userVm.listOfWorkouts[index], // WorkoutModel
                              'userModel': userVm, // UserModel
                            },
                          );
                        },
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
