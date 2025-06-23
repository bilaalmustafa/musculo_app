import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/logo_app_bar.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/program_tab.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/tab/program_tab.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/work_out_tab.dart';
import 'package:provider/provider.dart';

import '../../profile/profile_view_model/profile_view_model.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late ProfileProvider profileProvider;
  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    final String user = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFavorites( user);
    });
  }

  Future<void> _initializeFavorites(String user) async {
    await profileProvider.initFavoritesForUser(user);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
        title: "Discover",
        huintText: "Search workouts",
        buttonTabList: ["Workouts", "Programs"],
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
        children: [WorkOutTabDisScreen(), ProgramTabDisScreen()],

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
