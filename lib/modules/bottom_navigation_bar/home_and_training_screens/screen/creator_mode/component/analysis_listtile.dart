import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class AnalysisLisTile extends StatelessWidget {
  const AnalysisLisTile({
    super.key,
    required this.heading1,
    required this.heading2,
    this.icon,
    this.iconImage,
    this.iconColor,
  });
  final String heading1, heading2;
  final IconData? icon;
  final String? iconImage;
  final ColorFilter? iconColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: ConstColors.secondary,
          child:
              iconImage != null
                  ? SharePicture(
                    imagePath: iconImage!,
                    colorFilter: iconColor,
                    width: Sizes.s28,
                    height: Sizes.s28,
                  )
                  : Icon(icon),
        ),
        title: PoppinsText(
          text: heading1,
          fontSize: Sizes.s12,
          fontWeight: TextWeight.semiBold,
          color: ConstColors.greyA1A1,
        ),
        subtitle: PoppinsText(
          text: heading2,
          fontSize: Sizes.s14,
          fontWeight: TextWeight.semiBold,
          color: ConstColors.black,
        ),
      ),
    );
  }
}
