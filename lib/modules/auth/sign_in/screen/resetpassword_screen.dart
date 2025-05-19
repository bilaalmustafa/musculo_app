import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../../../../core/constants/sizes.dart';

class ResetpasswordScreen extends StatefulWidget {
  const ResetpasswordScreen({super.key});

  @override
  State<ResetpasswordScreen> createState() => _ResetpasswordScreenState();
}

class _ResetpasswordScreenState extends State<ResetpasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.s15,
          children: [
            QuestionText(questionText: 'Reset Your Password'),

            PoppinsText(
              text:
                  "No worries! We'll help you reset your password. Enter your registered email, and we'll send you an OTP code to verify your identity.",
              fontSize: Sizes.s14,
              fontWeight: TextWeight.regular,
              color: ConstColors.grey7575,
            ),
            PoppinsText(
              text: "Email",
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            CustomTextField(preIcon: Assets.message, title: "Email"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: CustomButton(
          onTap: () {
            // navigation handle here
            Navigator.pushNamed(context, Routes.verifyPasswordScreen);
          },

          buttonText: 'Continue',
        ),
      ),
    );
  }
}
