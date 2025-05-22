import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.suffexicon,
    this.controller,
    this.prefexicon,
    this.obscureText = false, this.onTap, this.validator,
   
  });
  final String title;
  final IconData? suffexicon;
  final IconData? prefexicon;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller:controller ,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
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
        prefixIcon:
            prefexicon != null
                ? Icon(prefexicon, size: 20, color: ConstColors.grey6A7)
                : null,
        suffixIcon:
            suffexicon != null
                ? IconButton(
                  icon: Icon(
                    suffexicon,
                    size: 20,
                    color: ConstColors.black1616,
                  ),
                  color: ConstColors.grey6A7,
                  onPressed: onTap,
                )
                : null,
      ),
    );
  }
}
