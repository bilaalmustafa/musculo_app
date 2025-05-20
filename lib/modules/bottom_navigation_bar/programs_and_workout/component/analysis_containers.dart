import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class AnalsisContainer extends StatelessWidget {
  const AnalsisContainer({
    super.key,
    this.icon,
    required this.digit,
    required this.text,
    this.iconImage,
  });
  final IconData? icon;
  final String digit, text;
  final String? iconImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s100,
      width: context.screenheight * 0.13,

      decoration: BoxDecoration(
        color: ConstColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: ConstColors.greyd9d9d9.withValues(alpha: .8),
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Sizes.s15),
          if (iconImage != null) SharePicture(imagePath: iconImage!),

          if (icon != null) Icon(icon),

          PoppinsText(
            text: digit,
            fontSize: Sizes.s16,
            fontWeight: TextWeight.semiBold,
          ),
          PoppinsText(
            text: text,
            fontSize: Sizes.s12,
            fontWeight: TextWeight.light,
          ),
        ],
      ),
    );
  }
}
