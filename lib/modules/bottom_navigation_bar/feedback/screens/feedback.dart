import 'package:flutter/material.dart';
import 'package:musculo_app/components/logo_title_appbar.dart';
// import 'package:musculo_app/components/poppins_text.dart';
// import 'package:musculo_app/components/logo_title_appbar.dart';
// import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/view_model/feedback_view_model.dart';
import 'package:provider/provider.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/feedbacktab.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/feedback/screens/reportstab.dart';

import '../../../../components/custom_button.dart';
// import '../../../../components/tab_buttons.dart';
import '../../../../core/constants/assets.dart';
// import '../../../../core/constants/fonts.dart';
import '../../../../core/services/auth_services.dart';
import '../../../auth/register/component/show_dialog_box.dart';
import '../components/feedbackfield.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final emailController = TextEditingController();
  final suggestionController = TextEditingController();
  final feedbackController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    suggestionController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColors.white,
      appBar: LogoTitleAppBar(title: ' Company Feedback'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.s16,
            vertical: Sizes.s24,
          ),
          child: Column(
            spacing: Sizes.s20,
            children: [
              SizedBox(height: 10),
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
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: CustomButton(
          loading: provider.isLoading,
          buttonText: 'Send Feedback',
          onTap: () async {
            await provider.submitFeedback(
              userId: AuthService().currentUser?.uid ?? 'anonymous',
              contentId: null,
              contentType: 'Company',
              email: emailController.text.toString().trim(),
              suggestion: suggestionController.text.toString().trim(),
              feedbackMessage: feedbackController.text.toString().trim(),
            );
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
