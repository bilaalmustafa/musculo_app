import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CongrateContainer extends StatelessWidget {
  const CongrateContainer({
    super.key,
    required this.text,
    required this.digit,
    required this.iconData,
  });
  final String text, digit;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: ConstColors.secondary, width: 2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData, color: ConstColors.black, size: 30),
            PoppinsText(
              text: digit,
              fontSize: Sizes.s18,
              fontWeight: TextWeight.semiBold,
            ),
            PoppinsText(
              text: text,
              fontSize: Sizes.s11,
              fontWeight: TextWeight.regular,
              color: ConstColors.greyA1A1,
            ),
          ],
        ),
      ),
    );
  }
}
