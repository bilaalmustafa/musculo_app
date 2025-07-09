import 'package:flutter/material.dart';

import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/feedback/components/feedbackfield.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/view_model/feedback_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/sizes.dart';
import '../../../auth/register/component/show_dialog_box.dart';

class FeedBScreen extends StatefulWidget {
  const FeedBScreen({
    super.key,
    required this.feedbackType,
    required this.contentId,
    this.rating,
    this.contentName,
  });
  final String feedbackType;
  final String? contentId;
  final double? rating;
  final String? contentName;

  @override
  State<FeedBScreen> createState() => _FeedBScreenState();
}

class _FeedBScreenState extends State<FeedBScreen> {
  final feedbackController = TextEditingController();
  final suggestionController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    feedbackController.dispose();
    suggestionController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>().userModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: widget.feedbackType),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Sizes.s16),
        child: Form(
          key: formKey,
          child: Column(
            spacing: Sizes.s20,
            children: [
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
                title: "Email",
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

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<FeedbackProvider>(
          builder: (context, provider, child) {
            return CustomButton(
              loading: provider.isLoading,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  await provider.submitFeedback(
                    userId: userViewModel!.userId ?? " Anonymous",
                    contentId: widget.contentId ?? "unknown",
                    rating: widget.rating ?? 0.0,
                    contentType: widget.feedbackType,
                    email: emailController.text.trim(),
                    suggestion: suggestionController.text.trim(),
                    feedbackMessage: feedbackController.text.trim(),
                    userName: userViewModel.name ?? " Anonymous",
                    contentName: widget.contentName ?? "unknown",
                  );

                  if (context.mounted) {
                    formKey.currentState?.reset();
                    emailController.clear();
                    suggestionController.clear();
                    feedbackController.clear();

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
                  }
                }
              },

              buttonText: 'Send Feedback',
            );
          },
        ),
      ),
    );
  }
}
