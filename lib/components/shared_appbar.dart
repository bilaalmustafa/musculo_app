import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  SharedAppBar({super.key, this.progress, this.title, this.actionIcon});
  double? progress;
  String? title;
  IconData? actionIcon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
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
        actionIcon != null ? Icon(actionIcon) : Container(),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, Sizes.s60);
}
