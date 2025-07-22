import 'package:flutter/material.dart';

import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedback.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/home_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/user_profile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/discover_screen.dart';
import 'package:provider/provider.dart';

import 'programs_and_workout/bottom_navigation_view_model.dart';
import 'programs_and_workout/screen/view_model/discover_filter_provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int initialMainTabIndex;
  final int initialHomeScreenSubTab;
  const BottomNavigationScreen({
    super.key,
    this.initialMainTabIndex = 0,
    this.initialHomeScreenSubTab = 0,
  });

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<Widget> get _screens {
    return [
      HomeScreen(
        initialTabIndex:
            widget.initialMainTabIndex == 0
                ? widget.initialHomeScreenSubTab
                : 0,
      ),
      DiscoverScreen(),
      FeedbackScreen(),
      UserProfile(),
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the provider instance (listen: false because we are only calling methods)
      final bottomProvider = Provider.of<BottomNavigationProvider>(
        context,
        listen: false,
      );

      // Set the initial main tab index in the provider
      bottomProvider.setIndex(widget.initialMainTabIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      body: _screens[bottomProvider.selectedIndex],
      backgroundColor: ConstColors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ConstColors.white,
        selectedItemColor: ConstColors.black,
        unselectedItemColor: ConstColors.greyA9A8,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold, // Your desired weight
          fontSize: 12,
        ),

        items: [
          BottomNavigationBarItem(
            icon: SharePicture(
              imagePath:
                  bottomProvider.selectedIndex == 0
                      ? Assets.home1
                      : Assets.homeIcon,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SharePicture(
              imagePath:
                  bottomProvider.selectedIndex == 1
                      ? Assets.discoveryIcon1
                      : Assets.discoveryIcon,
            ),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: SharePicture(
              imagePath:
                  bottomProvider.selectedIndex == 2
                      ? Assets.feedbackIcon1
                      : Assets.feedbackIcon,
            ),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: SharePicture(
              imagePath:
                  bottomProvider.selectedIndex == 3
                      ? Assets.profilIcon1
                      : Assets.profilIcon,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: bottomProvider.selectedIndex,
        onTap: (index) {
          if (bottomProvider.selectedIndex == 1 && index != 1) {
            final discoverProvider = Provider.of<DiscoverFilter>(
              context,
              listen: false,
            );
            discoverProvider.clear();
          }
          bottomProvider.setIndex(index);
        },
      ),
    );
  }
}
