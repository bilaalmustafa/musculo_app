import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/modules/auth/sign_in/component/social_button_row.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: Sizes.s20,
            children: [
              SharePicture(imagePath: Assets.monogram),
              PoppinsText(
                text: "Log Into You Account",
                fontSize: Sizes.s24,
                fontWeight: TextWeight.semiBold,
              ),

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    spacing: Sizes.s20,
                    children: [
                      CustomTextField(title: "Email", prefexicon: Icons.email),
                      CustomTextField(
                        title: "Password",
                        prefexicon: Icons.lock,
                        suffexicon: Icons.visibility,
                      ),
                      CustomButton(
                        buttonText: "Log In",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.bottomnavigationbarscreen,
                              (route) => false,
                            );
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          // navigate to forgot password screen
                          Navigator.pushNamed(
                            context,
                            Routes.resetPasswordScreen,
                          );
                        },
                        child: PoppinsText(
                          text: "Forgot the Password?",
                          color: ConstColors.black,

                          fontSize: Sizes.s13,
                          fontWeight: TextWeight.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              PoppinsText(
                text: "Or continue with",
                fontSize: Sizes.s13,
                color: ConstColors.greyB3B3,
                fontWeight: TextWeight.semiBold,
              ),

              SocialButtonRow(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PoppinsText(
                    text: "Dont't have an account?",
                    fontSize: Sizes.s13,
                    color: ConstColors.greyB3B3,
                    fontWeight: TextWeight.semiBold,
                  ),
                  TextButton(
                    onPressed:
                        () =>
                            Navigator.pushNamed(context, Routes.registerscreen),
                    child: PoppinsText(
                      text: "Register",
                      fontSize: Sizes.s13,
                      fontWeight: TextWeight.semiBold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
