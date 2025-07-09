import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/assets.dart';

import 'package:musculo_app/modules/auth/sign_in/component/social_icon_button.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model.dart';

class SocialButtonRow extends StatelessWidget {
  const SocialButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, veiwModel, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SocialIconButton(
              imagepath: Assets.facebook,
              onTap: () {
                veiwModel.signInWithFacebook(context);
              },
            ),
            SocialIconButton(
              imagepath: Assets.google,
              onTap: () {
                veiwModel.loginWithGoogle(context);
              },
            ),
            SocialIconButton(imagepath: Assets.apple),
          ],
        );
      },
    );
  }
}
