import 'package:flutter/material.dart';
import 'package:musculo_app/components/logo_title_appbar.dart';
// import 'package:musculo_app/components/poppins_text.dart';
// import 'package:musculo_app/components/logo_title_appbar.dart';
// import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/core/constants/sizes.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedbacktab.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/reportstab.dart';

import '../../../../components/custom_button.dart';
// import '../../../../components/tab_buttons.dart';
import '../../../../core/constants/assets.dart';
// import '../../../../core/constants/fonts.dart';
import '../../../auth/register/component/show_dialog_box.dart';
import '../components/feedbackfield.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // int _selectIndex = 0;
  // late PageController _pageController;
  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController();
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  final emailController = TextEditingController();
  final suggestionController = TextEditingController();
  final feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColors.white,
      appBar: LogoTitleAppBar(title: ' Compnay Feedback'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.s16,
          vertical: Sizes.s24,
        ),
        child: Column(
          spacing: Sizes.s20,
          children: [
            Feedbackfield(
              controller: feedbackController,
              hint: 'Feedback',
              maxline: 5,
            ),
            Feedbackfield(
              controller: suggestionController,
              hint: 'Suggestion for improvement ( Optional ) ',
              maxline: 5,
            ),
            Feedbackfield(
              controller: emailController,
              hint: 'Email ( optional )',
              height: Sizes.s60,
              prefixIcon: Assets.message,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: CustomButton(
          onTap: () {
            // navigation handle here
            showDialog(
              context: context,
              barrierColor: Colors.black.withValues(alpha: 0.9),
              builder: (BuildContext context) {
                return ShowDialogBox(
                  title: 'Feedback Sent!',
                  message: 'Thank you for your feedback',
                  bottomWidget: CustomButton(
                    buttonText: 'Back',
                    textColor: ConstColors.white,
                    buttonColor: ConstColors.black,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },

          buttonText: 'Send Feedback',
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: ConstColors.white,
    //   appBar: SharedAppBar(title: 'Company Feedback'),
    //   body: Padding(
    //     padding: EdgeInsets.all(Sizes.s16),
    //     child: Column(
    //       spacing: Sizes.s20,

    //       // children: [
    //       //   SizedBox(),
    //       //   TabButtons(
    //       //     selecttab: _selectIndex,
    //       //     onChange: (index) {
    //       //       setState(() {
    //       //         _selectIndex = index;
    //       //         _pageController.animateToPage(
    //       //           index,
    //       //           duration: Duration(milliseconds: 300),
    //       //           curve: Curves.easeIn,
    //       //         );
    //       //       });
    //       //     },
    //       //     tabNames: ['Feedback', 'Reports'],
    //       //   ),

    //       //   Expanded(
    //       //     child: PageView(
    //       //       controller: _pageController,
    //       //       physics: NeverScrollableScrollPhysics(),
    //       //       children: [Feedbacktab()],
    //       //     ),
    //       //   ),
    //       // ],
    //     ),
    //   ),
    // );
  }
}
