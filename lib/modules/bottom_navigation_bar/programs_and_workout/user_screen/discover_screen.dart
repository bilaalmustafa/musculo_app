import 'package:flutter/material.dart';
import 'package:musculo_app/components/logo_app_bar.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/program_tab.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/work_out_tab.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
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
        children: [WorkOutTab(), ProgramTab(tabselect: _currentPage)],

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
