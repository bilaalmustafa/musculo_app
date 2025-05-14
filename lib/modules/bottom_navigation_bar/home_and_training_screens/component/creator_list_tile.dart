import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CreatorListTile extends StatelessWidget {
  const CreatorListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(Assets.maskgroup),
      ),
      title: Wrap(
        spacing: Sizes.s0_5,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          PoppinsText(
            text: "Jhon bu",
            fontSize: Sizes.s14,
            fontWeight: TextWeight.semiBold,
          ),
          SharePicture(imagePath: Assets.official),
        ],
      ),
      subtitle: Wrap(
        spacing: Sizes.s0_5,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.star, color: ConstColors.orange, size: Sizes.s20),
          PoppinsText(
            text: "4.6 (54 review)",
            fontSize: Sizes.s10,
            fontWeight: TextWeight.regular,
            color: ConstColors.greyA1A1,
          ),
        ],
      ),
      trailing: CustomButton(
        buttonText: "See Profile",
        buttonHeight: Sizes.s36,
        buttonWidth: Sizes.s120,
        onTap: () {
          Navigator.pushNamed(context, Routes.coachProfile);
        },
      ),
    );
  }
}
