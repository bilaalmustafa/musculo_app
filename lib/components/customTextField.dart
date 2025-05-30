import 'package:flutter/material.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.suffexicon,
    this.controller,
    this.prefexicon,
    this.obscureText = false,
    this.onTap,
    this.enabled = true,
    this.validator,

    this.preIcon,
    this.sufIcon,
  });
  final String title;
  final IconData? suffexicon;
  final IconData? prefexicon;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onTap;
  final bool enabled;
  final String? Function(String?)? validator;

  final String? preIcon;
  final String? sufIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(
          color: ConstColors.grey6A7,
          fontSize: Sizes.s13,
        ),

        fillColor: ConstColors.secondary,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.s10),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.s10),
          borderSide: const BorderSide(color: ConstColors.secondary),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.s10),
          borderSide: const BorderSide(color: ConstColors.black, width: 2),
        ),
        prefixIcon: getPrefixIcon(),

        suffixIcon: getSuffixIcon(),
      ),
    );
  }

  Widget? getSuffixIcon() {
    if (suffexicon != null) {
      return IconButton(
        icon: Icon(suffexicon, size: 20, color: ConstColors.black1616),
        color: ConstColors.grey6A7,
        onPressed: onTap,
      );
    } else if (sufIcon != null) {
      return GestureDetector(
        onTap: onTap,
        child: SharePicture(imagePath: sufIcon!, fit: BoxFit.scaleDown),
      );
    }
    return null;
  }

  Widget? getPrefixIcon() {
    if (prefexicon != null) {
      return Icon(prefexicon, size: 20, color: ConstColors.grey6A7);
    } else if (preIcon != null) {
      return SharePicture(imagePath: preIcon!, fit: BoxFit.scaleDown);
    }
    return null;
  }
}
