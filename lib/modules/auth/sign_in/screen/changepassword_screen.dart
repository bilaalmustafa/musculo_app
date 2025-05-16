import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/poppins_text.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/constants/sizes.dart';
import '../../register/component/show_dialog_box.dart';

class ChangepasswordScreen extends StatefulWidget {
  const ChangepasswordScreen({super.key});

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  bool isObscure = true;
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
            QuestionText(questionText: 'Secure Your Account'),
            PoppinsText(
              text:
                  "Almost there! Create a new password for your Musculo account to keep it secure. Remember to choose a strong and unique password.",
              fontSize: Sizes.s14,
              fontWeight: TextWeight.regular,
            ),
            PoppinsText(
              text: "New Password",
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            CustomTextField(
              prefexicon: Icons.lock,
              title: "Password",
              suffexicon: isObscure ? Icons.visibility_off : Icons.visibility,
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
              prefexicon: Icons.lock,
              title: "Password",
              suffexicon: isObscure ? Icons.visibility_off : Icons.visibility,
              obscureText: isObscure,
              onTap:
                  () => setState(() {
                    isObscure = !isObscure;
                  }),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: CustomButton(
          onTap: () {
            // navigation handle here
            showDialog(
              context: context,
              barrierColor: Colors.black.withValues(alpha: 0.9),
              builder: (BuildContext context) {
                return ShowDialogBox(
                  message:
                      'Your account is ready to use. You will be redirected to the home page in a few seconds..',
                  bottomWidget: Image(image: AssetImage(Assets.vector)),
                );
              },
            );
          },

          buttonText: 'Change',
        ),
      ),
    );
  }
}
