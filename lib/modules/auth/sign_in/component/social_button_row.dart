// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/modules/auth/sign_in/component/social_icon_button.dart';

class SocialButtonRow extends StatelessWidget {
  const SocialButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SocialIconButton(imagepath: Assets.facebook),
        SocialIconButton(imagepath: Assets.google),
        SocialIconButton(imagepath: Assets.apple),
      ],
    );
  }
}
