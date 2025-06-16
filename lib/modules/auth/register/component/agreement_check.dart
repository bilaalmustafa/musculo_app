import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class AgreementCheck extends StatelessWidget {
  const AgreementCheck({
    super.key,
    this.isChecked = false,
    required this.onChanged,
    required this.title,
    this.fontSize,
    required this.isSelected,
  });

  final bool isChecked, isSelected;
  final ValueChanged onChanged;
  final String title;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Sizes.s1_5,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: PoppinsText(
            text: title,
            fontSize: fontSize ?? Sizes.s14,
            fontWeight: TextWeight.medium,
          ),
          leading: Checkbox(
            activeColor: Colors.black,

            value: isChecked,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            side: BorderSide(
              color: isSelected ? ConstColors.red : ConstColors.black,
              width: 1.5,
            ),
            onChanged: onChanged,
          ),
        ),
        Divider(color: ConstColors.secondary, thickness: 1),
      ],
    );
  }
}
