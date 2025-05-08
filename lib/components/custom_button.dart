import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.buttonWidth = double.infinity,
    this.buttonColor = ConstColors.black,
    this.textColor = ConstColors.white,
    this.onTap,
  });
  final String buttonText;
  final double buttonWidth;
  final Color buttonColor, textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Sizes.s50,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(Sizes.s10),
        ),
        child: Center(
          child: PoppinsText(
            text: buttonText,
            fontSize: Sizes.s13,
            color: textColor,
            fontWeight: TextWeight.semiBold,
          ),
        ),
      ),
    );
  }
}
