import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/component/home_app_bar.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/creator_mode.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/user_mode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: HomeAppBar(
        isSwitch: isSwitch,
        valueChange:
            (value) => setState(() {
              isSwitch = value;
              _pageController.jumpToPage(value ? 1 : 0);
            }),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [UserModeTab(), CreatorModeTab()],
      ),
    );
  }
}
