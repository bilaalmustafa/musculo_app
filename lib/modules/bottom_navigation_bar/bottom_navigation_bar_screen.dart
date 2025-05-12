import 'package:flutter/material.dart';
import 'package:musculo_app/components/logo_app_bar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/home_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/discover_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [HomeScreen(), DiscoverScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      //     _selectedIndex == 0
      //         ? null
      //         : LogoAppBar(
      //           selectedindex: tabselect,
      //           onSelected:
      //               (value) => setState(() {
      //                 tabselect = value;
      //               }),
      //         ),
      body: _screens[_selectedIndex],
      backgroundColor: ConstColors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ConstColors.white,
        selectedItemColor: ConstColors.black,
        unselectedItemColor: ConstColors.greyA9A8,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_sharp),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap:
            (value) => setState(() {
              _selectedIndex = value;
            }),
      ),
    );
  }
}
