import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

class TabButtons extends StatelessWidget {
  const TabButtons({
    super.key,
    required this.selecttab,
    required this.onChange,
    required this.tabNames,
  });
  final int selecttab;
  final Function(int) onChange;
  final List<String> tabNames;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(tabNames.length, (int index) {
          bool selectindex = index == selecttab;
          return Expanded(
            child: CustomButton(
              buttonHeight: 40,
              buttonText: tabNames[index],
              textColor: selectindex ? ConstColors.white : ConstColors.black,
              buttonColor:
                  selectindex ? ConstColors.black : ConstColors.secondary,
              onTap: () {
                onChange(index);
              },
            ),
          );
        }),
      ),
    );
  }
}
