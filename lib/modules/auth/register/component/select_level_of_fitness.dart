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
    required this.groupValue,
    this.onChanged,
    required this.color,
  });

  final String fitnessLevel, value, groupValue;
  final ValueChanged<String?>? onChanged;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
      trailing: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: ConstColors.black,
      ),
    );
  }
}
