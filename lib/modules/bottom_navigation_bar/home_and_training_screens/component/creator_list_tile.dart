import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../../../../model/user_model.dart';

class CreatorListTile extends StatelessWidget {
  final UserModel creator;
  const CreatorListTile({super.key, required this.creator});

  @override
  Widget build(BuildContext context) {
    // final creatorVm = context.read<UserViewModel>();
    // final data = creatorVm.userModel;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage:
            creator.profileImageUrl != null
                ? NetworkImage(creator.profileImageUrl ?? "")
                : null,
        backgroundColor: creator.profileImageUrl == null ? Colors.black : null,
        child:
            creator.profileImageUrl == null
                ? PoppinsText(
                  text: creator.name![0].toUpperCase(),
                  fontSize: 30,
                  fontWeight: TextWeight.semiBold,
                  color: ConstColors.white,
                )
                : null,
      ),
      title: Wrap(
        spacing: Sizes.s0_5,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          PoppinsText(
            text: creator.name ?? "unknown",
            fontSize: Sizes.s14,
            fontWeight: TextWeight.semiBold,
          ),

          creator.subPlane == "Basic"
              ? Container()
              : SharePicture(imagePath: Assets.official),
        ],
      ),
      subtitle: Wrap(
        spacing: Sizes.s0_5,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.star, color: ConstColors.orange, size: Sizes.s20),
          PoppinsText(
            text:
                "${creator.rating!.toStringAsFixed(1)} (${creator.review.length} review)",
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
          Navigator.pushNamed(
            context,
            Routes.coachProfile,
            arguments: creator.userId,
          );
        },
      ),
    );
  }
}
