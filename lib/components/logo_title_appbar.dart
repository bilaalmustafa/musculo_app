// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../core/constants/assets.dart';
import 'share_picture.dart';

class LogoTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  LogoTitleAppBar({super.key, required this.title});

  String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColors.white,
      leading: SharePicture(imagePath: Assets.monogram, height: 30),
      title: PoppinsText(
        text: title,
        fontSize: Sizes.s20,
        fontWeight: TextWeight.semiBold,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Sizes.s30);
}
