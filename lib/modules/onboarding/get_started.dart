import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,

      body: Column(
        spacing: Sizes.s10,
        children: [
          Image.asset(Assets.maskgroup),
          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.s30,
              vertical: Sizes.s10,
            ),
            child: Column(
              spacing: Sizes.s10,
              children: [
                PoppinsText(
                  text: "Welcome to Musculo 👋 ",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
                ),
                PoppinsText(
                  textAlign: TextAlign.center,
                  text:
                      "Get ready to embark on a transformative fitness journey with Musculo.",
                  color: ConstColors.greyB3B3,
                  fontSize: Sizes.s13,
                  fontWeight: TextWeight.semiBold,
                ),
                SizedBox(height: context.screenheight * 0.02),
                CustomButton(
                  buttonText: "Register",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.registerscreen);
                  },
                ),
                CustomButton(
                  buttonText: "Sign in",
                  buttonColor: ConstColors.secondary,
                  textColor: ConstColors.black,
                  onTap:
                      () => Navigator.pushNamed(context, Routes.signInscreen),
                ),
                SizedBox(height: Sizes.s10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
