import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/components/profileappbar.dart';
import 'package:musculo_app/model/programs_%20model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/programes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/workouts.dart';
import 'package:provider/provider.dart';

class Myprogramworkout extends StatefulWidget {
  const Myprogramworkout({super.key});
 
  @override
  State<Myprogramworkout> createState() => _MyprogramworkoutState();
}

class _MyprogramworkoutState extends State<Myprogramworkout> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final userVm = context.watch<UserViewModel>();
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
          WorkOuts(),
          Programs(
            tabselect: _currentPage,
           
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
