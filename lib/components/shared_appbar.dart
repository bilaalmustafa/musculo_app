// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  SharedAppBar({
    super.key,
    this.progress,
    this.title,
    this.actionIcon,
    this.iconImage,
    this.trailing,
    this.onBackPressed,
  });
  double? progress;
  String? title;
  IconData? actionIcon;
  String? iconImage;
  final Widget? trailing;
  final VoidCallback? onBackPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColors.white,
      leading: IconButton(
        icon: const SharePicture(imagePath: Assets.arrowleft),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      title:
          title != null
              ? PoppinsText(
                text: title!,
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              )
              : progress != null
              ? SizedBox(
                width: 250,
                child: LinearProgressIndicator(
                  backgroundColor: ConstColors.secondary,
                  value: progress,
                  minHeight: 7,
                  color: ConstColors.black,
                ),
              )
              : null,
      actions: [
        actionIcon != null
            ? Icon(actionIcon)
            : iconImage != null
            ? SharePicture(imagePath: iconImage!)
            : trailing != null
            ? trailing!
            : Container(),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, Sizes.s60);
}
