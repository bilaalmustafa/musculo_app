import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';

import '../../../../core/constants/sizes.dart';

class CustomChips extends StatelessWidget {
  const CustomChips({
    super.key,
    required this.optionslist,
    required this.selectedIndex,
    required this.onSelect,
  });
  final List<String> optionslist;
  final dynamic selectedIndex;
  final ValueChanged onSelect;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: List.generate(optionslist.length, (index) {
        final isSelected = selectedIndex == index;
        return ChoiceChip(
          label: PoppinsText(
            text: optionslist[index],
            fontSize: Sizes.s14,
            fontWeight: TextWeight.medium,
            color: isSelected ? ConstColors.white : ConstColors.black,
          ),

          selected: isSelected,
          selectedColor: ConstColors.black,
          backgroundColor: ConstColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s20),
            side: BorderSide(color: ConstColors.black),
          ),
          onSelected: (selected) {
            onSelect(index);
          },
        );
      }),
    );
  }
}
