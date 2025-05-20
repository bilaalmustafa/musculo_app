import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class GenderSelectionButton extends StatelessWidget {
  const GenderSelectionButton({
    super.key,
    required this.gendertitle,
    this.gendericon,
    required this.gendercolor,
    this.gendericonimage,
    this.onTap,
  });
  final String gendertitle;
  final IconData? gendericon;
  final Color gendercolor;
  final VoidCallback? onTap;
  final String? gendericonimage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: Sizes.s80,
        backgroundColor: gendercolor,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildGenderIcon(),
            PoppinsText(
              text: gendertitle,
              fontSize: Sizes.s20,
              fontWeight: TextWeight.semiBold,
              color: ConstColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenderIcon() {
    if (gendericon != null) {
      return Icon(gendericon, size: Sizes.s80, color: ConstColors.white);
    } else if (gendericonimage != null) {
      return SharePicture(
        imagePath: gendericonimage!,
        width: Sizes.s50,
        height: Sizes.s50,
      );
    } else {
      return const SizedBox.shrink(); // returns empty widget
    }
  }
}
