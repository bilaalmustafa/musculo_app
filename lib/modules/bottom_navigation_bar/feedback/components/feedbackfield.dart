import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class Feedbackfield extends StatelessWidget {
  final TextEditingController controller;
  final IconData? preIcon;
  final IconData? sufIcon;
  final String hint;
  final bool obsecureText;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? textColor;
  final Color? hintColor;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? hintSize;
  final double? height;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onSufixTap;
  final String? obsecureCharacter;
  final FontWeight? fontWeight;
  final int? maxline;

  const Feedbackfield({
    super.key,
    required this.controller,
    this.preIcon,
    this.sufIcon,
    required this.hint,
    this.obsecureText = false,
    this.fillColor,
    this.cursorColor,
    this.textColor,
    this.hintColor,
    this.paddingVertical,
    this.paddingHorizontal,
    this.hintSize,
    this.height,
    this.validator,
    this.onSufixTap,
    this.obsecureCharacter,
    this.fontWeight,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Sizes.s145,
      padding: EdgeInsets.symmetric(
        vertical: paddingVertical ?? 12,
        horizontal: paddingHorizontal ?? 12,
      ),
      decoration: BoxDecoration(
        color: fillColor ?? ConstColors.greyFAFA,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        obscuringCharacter: obsecureCharacter ?? '●',
        maxLines: maxline ?? 1,
        validator: validator,
        cursorColor: cursorColor ?? ConstColors.gre9E9E,
        style: TextStyle(
          color: textColor ?? ConstColors.black,
          fontWeight: fontWeight ?? TextWeight.regular,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: hintSize ?? Sizes.s14,
            color: hintColor ?? ConstColors.gre9E9E,
            fontWeight: fontWeight ?? TextWeight.regular,
          ),
          prefixIcon:
              preIcon != null
                  ? Icon(preIcon, size: 18, color: ConstColors.gre9E9E)
                  : null,
          suffixIcon:
              sufIcon != null
                  ? GestureDetector(
                    onTap: onSufixTap,
                    child: Icon(sufIcon, size: 18, color: ConstColors.gre9E9E),
                  )
                  : null,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
