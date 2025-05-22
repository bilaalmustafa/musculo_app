import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/components/tab_buttons.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/informationtab.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/creator_profile_screens/paymenttab.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/sizes.dart';

class CreatorProfileScreen extends StatefulWidget {
  const CreatorProfileScreen({super.key});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen> {
  int _selectIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
      appBar: SharedAppBar(title: 'Creator Profile'),
      body: Padding(
        padding: EdgeInsets.all(Sizes.s16),
        child: Column(
          spacing: Sizes.s20,
          children: [
            TabButtons(
              selecttab: _selectIndex,
              onChange: (index) {
                setState(() {
                  _selectIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                });
              },
              tabNames: ['Information', 'Payment'],
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [Informationtab(), Paymenttab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
