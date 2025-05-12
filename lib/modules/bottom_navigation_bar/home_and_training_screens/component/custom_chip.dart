import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CustomChip extends StatelessWidget {
  CustomChip({super.key, required this.text, this.color = ConstColors.white});
  final String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 33,

      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: PoppinsText(
        text: text,
        fontSize: Sizes.s10,
        fontWeight: TextWeight.regular,
        color: ConstColors.black2626,
      ),
    );
  }
}
