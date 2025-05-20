import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../components/custom_button.dart';
import '../../../../core/constants/sizes.dart';

class VerifypasswordScreen extends StatelessWidget {
  const VerifypasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          spacing: Sizes.s40,
          children: [
            Center(
              child: SharePicture(
                imagePath: Assets.mailDraw,
                width: Sizes.s230,
                height: Sizes.s200,
              ),
            ),
            PoppinsText(
              text: 'Code has been send to \nYouremail@gmail.com',
              fontSize: Sizes.s14,
              fontWeight: TextWeight.medium,
            ),
            Pinput(
              length: 4,
              onCompleted: (value) {
                debugPrint('Entered PIN: $value');
              },
              defaultPinTheme: PinTheme(
                width: 70,
                height: 50,
                textStyle: const TextStyle(
                  fontSize: Sizes.s20,
                  color: ConstColors.black,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  color: ConstColors.greyEEE,
                  border: Border.all(color: ConstColors.greyA9A8),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              ),
            ),

            PoppinsText(
              text: 'Resend code in 53 s',
              fontSize: Sizes.s14,
              fontWeight: TextWeight.medium,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: CustomButton(
          onTap: () {
            // navigation handle here
            Navigator.pushNamed(context, Routes.changePasswordScreen);
          },

          buttonText: 'Verify',
        ),
      ),
    );
  }
}
