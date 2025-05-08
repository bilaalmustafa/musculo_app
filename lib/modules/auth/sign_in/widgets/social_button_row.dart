import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musculo_app/modules/auth/sign_in/widgets/social_icon_Button.dart';
import 'package:musculo_app/core/constants/assets.dart';

class SocialButtonRow extends StatelessWidget {
  const SocialButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SocialIconButton(imagePath: Assets.facebook),

        SocialIconButton(imagePath: Assets.google),
        SvgPicture.asset("assets/images/facebook.svg", height: 25),

        // SocialIconButton(imagePath: Assets.apple),
      ],
    );
  }
}
