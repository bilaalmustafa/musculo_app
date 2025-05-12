import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SelectLevelOfFitness extends StatelessWidget {
  const SelectLevelOfFitness({
    super.key,
    required this.fitnessLevel,
    required this.value,
    this.onChanged,
    required this.color,
  });
  final String fitnessLevel, value;
  final ValueChanged? onChanged;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(Sizes.s16),
      ),
      tileColor: ConstColors.white,

      title: PoppinsText(
        text: fitnessLevel,
        fontWeight: TextWeight.medium,
        fontSize: Sizes.s16,
      ),
      trailing: Radio(
        value: fitnessLevel,
        groupValue: "fitnessLevel",
        onChanged: onChanged,
      ),
    );
  }
}
