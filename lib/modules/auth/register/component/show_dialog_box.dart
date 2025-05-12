import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class ShowDialogBox extends StatelessWidget {
  const ShowDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
                    backgroundColor: ConstColors.white,
                    title: Image(image: AssetImage(Assets.group)),
                    content: Column(
                      spacing: Sizes.s20,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PoppinsText(
                          text: "Congratulation!",
                          fontSize: Sizes.s24,
                          fontWeight: TextWeight.semiBold,
                        ),
                        PoppinsText(
                          textAlign: TextAlign.center,
                          text:
                              "Your account is ready to use. You will be redirected to the home page in a few seconds.",
                          fontSize: Sizes.s13,
                          fontWeight: TextWeight.regular,
                        ),
                        Image(image: AssetImage(Assets.vector)),
                      ],
                    ),
                  );
  }
}