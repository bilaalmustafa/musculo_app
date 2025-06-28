import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/components/profileappbar.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/programes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/workouts.dart';
import 'package:provider/provider.dart';

class CreatorMyprogramworkout extends StatefulWidget {
  const CreatorMyprogramworkout({super.key});

  @override
  State<CreatorMyprogramworkout> createState() =>
      _CreatorMyprogramworkoutState();
}

class _CreatorMyprogramworkoutState extends State<CreatorMyprogramworkout> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Stream<List<WorkoutModel>>? _workoutStream;
  Stream<List<ProgramModel>>? _programStream;
  late UserViewModel userVm;

  @override
  void initState() {
    userVm = context.read<UserViewModel>();
    final String uid = userVm.userModel!.userId ?? "";
    _workoutStream = instance<WorkoutServices>().getCreatorWorkout(uid);
    _programStream = instance<ProgramServices>().getCreatorPrograms(uid);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log("User Model: ${userVm.userModel?.listOfPrograms}");

    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: ProfileAppBar(
        appbarTitle: 'My Programs/Workouts',
        selectedindex: _currentPage,
        onSelected: (value) {
          setState(() {
            _currentPage = value;
          });
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: PageView(
        controller: _pageController,

        physics: const NeverScrollableScrollPhysics(),
        children: [
          StreamBuilder<List<WorkoutModel>>(
            stream: _workoutStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No workouts '));
              }

              return WorkOuts(workoutModelList: snapshot.data!);
            },
          ),

          StreamBuilder<List<ProgramModel>>(
            stream: _programStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No  programs'));
              }

              return Programs(
                tabselect: _currentPage,
                programModelList: snapshot.data!,
              );
            },
          ),
        ],

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstColors.black,
        shape: const CircleBorder(),

        onPressed: () {
          // here floating action code here
        },
        child: Icon(Icons.add, color: ConstColors.white),
      ),
    );
  }
}
