import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  SharedAppBar({super.key, this.progress});
  double? progress;

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
          progress != null
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
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, Sizes.s60);
}
