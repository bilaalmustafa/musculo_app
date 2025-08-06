import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/modules/auth/sign_in/screen/resetpassword_screen.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:musculo_app/modules/auth/view_model/forgot_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/poppins_text.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/constants/sizes.dart';
import '../../register/component/show_dialog_box.dart';

class ChangepasswordScreen extends StatefulWidget {
  const ChangepasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });
  final String email, otp;
  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isObscure = true;
  bool cobscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Sizes.s15,
            children: [
              QuestionText(questionText: 'Secure Your Account'),
              PoppinsText(
                text:
                    "Almost there! Create a new password for your Musculo account to keep it secure. Remember to choose a strong and unique password.",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.regular,
                color: ConstColors.grey7575,
              ),
              PoppinsText(
                text: "New Password",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              CustomTextField(
                controller: _newPasswordController,
                validator: (value) => Validator.passwordCorrect(value),
                preIcon: Assets.lock,
                title: "Password",
                sufIcon: isObscure ? Assets.hide : Assets.show,

                obscureText: isObscure,
                onTap:
                    () => setState(() {
                      isObscure = !isObscure;
                    }),
              ),
              PoppinsText(
                text: "Confirm Password",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              CustomTextField(
                controller: _confirmPasswordController,
                validator:
                    (value) => Validator.passwordConfirmed(
                      value,
                      _newPasswordController.text,
                    ),
                preIcon: Assets.lock,
                title: "Confirm Password",
                sufIcon: cobscure ? Assets.hide : Assets.show,

                obscureText: cobscure,
                onTap:
                    () => setState(() {
                      cobscure = !cobscure;
                    }),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Consumer<PasswordResetProvider>(
          builder: (context, vm, _) {
            return CustomButton(
              loading: vm.isverified,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  if (_newPasswordController.text ==
                      _confirmPasswordController.text) {
                    bool success = await vm.resetPassword(
                      _newPasswordController.text.trim(),
                      widget.otp,
                      widget.email,
                    );
                    if (success && context.mounted) {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withValues(alpha: 0.9),
                        builder: (BuildContext context) {
                          return ShowDialogBox(
                            message:
                                'Your account is ready to use. You will be redirected to the home page in a few seconds..',
                            bottomWidget: Image(
                              image: AssetImage(Assets.vector),
                            ),
                          );
                        },
                      );
                      final vm = context.read<AuthViewModel>();
                   await   vm.signIn(
                        widget.email,
                        _newPasswordController.text.trim(),
                      );

                      await Future.delayed(Duration(seconds: 5), () {
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.bottomnavigationbarscreen,

                            (route) => false,
                          );
                        }
                      });
                    }
                  } else {
                    Fluttertoast.showToast(msg: "Passwords do not match");
                  }
                }

                // navigation handle here
              },

              buttonText: 'Change',
            );
          },
        ),
      ),
    );
  }
}
