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
  });

  final bool isChecked;
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
            fontSize: fontSize ?? Sizes.s16,
            fontWeight: TextWeight.medium,
          ),
          leading: Checkbox(
            activeColor: Colors.black,

            value: isChecked,
            onChanged: (value) {
              // Handle checkbox state change
            },
          ),
        ),
        Divider(color: ConstColors.secondary, thickness: 2),
      ],
    );
  }
}
