import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({super.key, required this.imagepath, this.onTap});
  final String imagepath;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Sizes.s50,
        width: Sizes.s80,
        decoration: BoxDecoration(
          border: Border.all(color: ConstColors.secondary),
          borderRadius: BorderRadius.circular(Sizes.s10),
        ),
        child: Center(child:  SharePicture(imagePath: imagepath),),
      ),
    );
  }
}
