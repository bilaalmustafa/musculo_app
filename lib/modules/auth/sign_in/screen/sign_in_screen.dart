import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';

import 'package:musculo_app/core/config/validator.dart';

import 'package:musculo_app/modules/auth/sign_in/component/social_button_row.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../model/user_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      // appBar: SharedAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<AuthViewModel>(
            builder: (context, vm, _) {
              return Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  spacing: Sizes.s20,

                  children: [
                    // SizedBox(height: 60),
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
                            CustomTextField(
                              controller: _emailController,
                              title: "Email",
                              preIcon: Assets.message,
                              validator:
                                  (value) => Validator.validateEmail(value),
                            ),
                            CustomTextField(
                              controller: _passController,
                              title: "Password",
                              preIcon: Assets.lock,
                              sufIcon: isObscure ? Assets.hide : Assets.show,

                              validator:
                                  (value) => Validator.passwordCorrect(value),
                              obscureText: isObscure,
                              onTap:
                                  () => setState(() {
                                    isObscure = !isObscure;
                                  }),
                            ),
                            CustomButton(
                              loading: vm.isLoading,
                              buttonText: "Log In",
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  User? user = await vm.signIn(
                                    _emailController.text.trim(),
                                    _passController.text.trim(),
                                  );
                                  if (user != null && context.mounted) {
                                    UserModel? userDoc = await context
                                        .read<UserViewModel>()
                                        .getUserById(user.uid);
                                    if (userDoc != null) {
                                      if (userDoc.role != "admin") {
                                        Fluttertoast.showToast(
                                          msg: "Signin Successfully",
                                        );
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.bottomnavigationbarscreen,
                                          (route) => false,
                                        );
                                      } else {
                                        await FirebaseAuth.instance.signOut();
                                        Fluttertoast.showToast(
                                          msg:
                                              "Admins cannot log in to the app.",
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "User data not found.",
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.resetPasswordScreen,
                                );
                              },
                              child: PoppinsText(
                                text: "Forgot the Password?",
                                fontSize: Sizes.s13,
                                fontWeight: TextWeight.semiBold,
                                color: ConstColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: ConstColors.greyB3B3,
                            thickness: 0.5,
                            indent: 16,
                            endIndent: 10,
                          ),
                        ),
                        PoppinsText(
                          text: "Or continue with",
                          fontSize: Sizes.s13,
                          color: ConstColors.greyB3B3,
                          fontWeight: TextWeight.semiBold,
                        ),
                        Expanded(
                          child: Divider(
                            color: ConstColors.greyB3B3,
                            thickness: 0.5,
                            indent: 10,
                            endIndent: 16,
                          ),
                        ),
                      ],
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
                              () => Navigator.pushNamed(
                                context,
                                Routes.registerscreen,
                              ),
                          child: PoppinsText(
                            text: "Register",
                            fontSize: Sizes.s13,
                            fontWeight: TextWeight.semiBold,
                            color: ConstColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
