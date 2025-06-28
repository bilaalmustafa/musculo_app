import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/logo_app_bar.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_filter_provider.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_view_model.dart';

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
  final TextEditingController _searchController = TextEditingController();

  int _currentPage = 0;
  late ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFavorites();
    });
    _searchController.addListener(() {
      context.read<DiscoverFilter>().setQuery(_searchController.text);
    });
  }

  Future<void> _initializeFavorites() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await profileProvider.initFavoritesForUser(user.uid);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
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
        controller: _searchController,
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
