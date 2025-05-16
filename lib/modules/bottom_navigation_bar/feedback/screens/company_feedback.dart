import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/components/feedbackfield.dart';

import '../../../../components/custom_button.dart';
import '../../../../core/constants/sizes.dart';
import '../../../auth/register/component/show_dialog_box.dart';

class CompanyFeedbackScreen extends StatefulWidget {
  const CompanyFeedbackScreen({super.key});

  @override
  State<CompanyFeedbackScreen> createState() => _CompanyFeedbackScreenState();
}

class _CompanyFeedbackScreenState extends State<CompanyFeedbackScreen> {
  final feedbackController = TextEditingController();
  final suggestionController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    suggestionController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Company'),
      body: Padding(
        padding: EdgeInsets.all(Sizes.s16),
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
              preIcon: Icons.email_rounded,
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
  }
}
