import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.s16),
      child: Column(
        spacing: Sizes.s20,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionText(
            questionText: "Enter the email and password of your account.",
          ),
          PoppinsText(
            text: "Email",
            fontSize: Sizes.s16,
            fontWeight: TextWeight.semiBold,
          ),
          CustomTextField(preIcon: Assets.message, title: "Email"),
          PoppinsText(
            text: "Password",
            fontSize: Sizes.s16,
            fontWeight: TextWeight.semiBold,
          ),
          CustomTextField(
            preIcon: Assets.lock,
            title: "Password",
            sufIcon: isObscure ? Assets.hide : Assets.show,
            obscureText: isObscure,
            onTap:
                () => setState(() {
                  isObscure = !isObscure;
                }),
          ),
        ],
      ),
    );
  }
}
