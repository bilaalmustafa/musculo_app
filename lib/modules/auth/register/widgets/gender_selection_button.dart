import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class GenderSelectionButton extends StatelessWidget {
  const GenderSelectionButton({super.key, required this.gendertitle, required this.gendericon, required this.gendercolor, this.onTap});
  final String gendertitle;
  final IconData gendericon;
  final Color gendercolor;
  final VoidCallback? onTap;
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
            Icon(gendericon, size: Sizes.s80, color: ConstColors.white),
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
}
