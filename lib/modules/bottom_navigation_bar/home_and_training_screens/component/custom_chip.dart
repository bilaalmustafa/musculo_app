import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

// ignore: must_be_immutable
class CustomChip extends StatelessWidget {
  CustomChip({super.key, required this.text, this.color = ConstColors.white});
  final String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 25,

      decoration: BoxDecoration(
        color: color.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(8),
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
