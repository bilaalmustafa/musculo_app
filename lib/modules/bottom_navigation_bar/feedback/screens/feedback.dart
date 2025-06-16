import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/logo_title_appbar.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/view_model/feedback_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';

import '../../../../core/constants/assets.dart';

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
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    suggestionController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: formkey,
            child: Column(
              spacing: Sizes.s20,
              children: [
                SizedBox(height: 10),
                Feedbackfield(
                  controller: feedbackController,
                  hint: 'Feedback',
                  maxline: 5,
                  validator: (value) => Validator.valueExists(value),
                ),
                Feedbackfield(
                  controller: suggestionController,
                  hint: 'Suggestion for improvement ( Optional ) ',
                  maxline: 5,
                ),

                CustomTextField(
                  controller: emailController,
                  title: "Email (optional)",
                  preIcon: Assets.message,
                  validator: (value) => Validator.emailValidate(value),
                ),
                // Feedbackfield(
                //   controller: emailController,
                //   hint: 'Email ( optional )',
                //   height: Sizes.s60,
                //   prefixIcon: Assets.message,
                //   validator: (value) => Validator.emailValidate(value),
                // ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<FeedbackProvider>(
          builder: (context, provider, child) {
            return CustomButton(
              loading: provider.isLoading,
              buttonText: 'Send Feedback',
              onTap: () async {
                if (formkey.currentState!.validate()) {
                  await provider.submitFeedback(
                    userId: AuthService().currentUser?.uid ?? 'anonymous',
                    contentId: null,
                    contentType: 'Company',
                    email: emailController.text.trim(),
                    suggestion: suggestionController.text.trim(),
                    feedbackMessage: feedbackController.text.trim(),
                  );

                  if (context.mounted) {
                    // Reset fields
                    formkey.currentState?.reset();
                    emailController.clear();
                    suggestionController.clear();
                    feedbackController.clear();

                    Fluttertoast.showToast(msg: 'Feedback Submitted');

                    //show dialog
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
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
