import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/components/feedbackfield.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/view_model/feedback_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_button.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/sizes.dart';
import '../../../auth/register/component/show_dialog_box.dart';

class FeedBScreen extends StatefulWidget {
  const FeedBScreen({super.key, required this.feedbackType});
  final String feedbackType;

  @override
  State<FeedBScreen> createState() => _FeedBScreenState();
}

class _FeedBScreenState extends State<FeedBScreen> {
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
    final provider = Provider.of<FeedbackProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: widget.feedbackType),
      body: SingleChildScrollView(
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
              prefixIcon: Assets.message,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: CustomButton(
          loading: provider.isLoading,
          onTap: () async {
            await provider.submitFeedback(
              userId: AuthService().currentUser?.uid ?? 'anonymous',
              contentId: null,
              contentType: widget.feedbackType,
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

          buttonText: 'Send Feedback',
        ),
      ),
    );
  }
}
