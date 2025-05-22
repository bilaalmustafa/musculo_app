import 'package:flutter/material.dart';
import 'package:musculo_app/components/logo_title_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedbacktab.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/reportstab.dart';

import '../../../../components/tab_buttons.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
      appBar: LogoTitleAppBar(title: 'Feedback'),
      body: Padding(
        padding: EdgeInsets.all(Sizes.s16),
        child: Column(
          spacing: Sizes.s20,

          children: [
            SizedBox(),
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
              tabNames: ['Feedback', 'Reports'],
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [Feedbacktab(), Reportstab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
