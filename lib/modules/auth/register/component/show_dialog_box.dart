import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class ShowDialogBox extends StatelessWidget {
  final String message;
  final Widget? bottomWidget;
  final String? title;
  const ShowDialogBox({
    super.key,
    required this.message,
    this.bottomWidget,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ConstColors.white,
      title: Image(image: AssetImage(Assets.group)),
      content: Column(
        spacing: Sizes.s20,
        mainAxisSize: MainAxisSize.min,
        children: [
          PoppinsText(
            text: title ?? "Congratulation!",
            fontSize: Sizes.s24,
            fontWeight: TextWeight.semiBold,
          ),
          PoppinsText(
            textAlign: TextAlign.center,
            text: message,

            fontSize: Sizes.s13,
            fontWeight: TextWeight.regular,
          ),
          // Image(image: AssetImage(Assets.vector)),
          if (bottomWidget != null) bottomWidget!,
        ],
      ),
    );
  }
}
