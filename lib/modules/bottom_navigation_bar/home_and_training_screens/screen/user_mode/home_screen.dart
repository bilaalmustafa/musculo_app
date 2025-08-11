import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/component/home_app_bar.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/creator_mode.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/user_mode.dart';


class HomeScreen extends StatefulWidget {
  final int initialTabIndex;
  const HomeScreen({super.key, this.initialTabIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  bool isSwitch = false;

  @override
  void initState() {
    super.initState();
    //Initialize PageController with the provided initial tab index
    _pageController = PageController(initialPage: widget.initialTabIndex);

    // set the intial state of the switch
    isSwitch = widget.initialTabIndex == 1;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
