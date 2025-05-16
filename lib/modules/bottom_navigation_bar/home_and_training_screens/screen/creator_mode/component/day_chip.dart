import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class DaysChip extends StatelessWidget {
  const DaysChip({
    super.key,
    required this.selectTab,
    required this.onTap,
    required this.daylist,
  });
  final int selectTab;
  final Function(int) onTap;
  final List<String> daylist;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(daylist.length, (index) {
        bool select = selectTab == index;
        return InkWell(
          onTap: () => onTap(index),

          child: Container(
            margin: EdgeInsets.all(5),

            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: select ? ConstColors.white : ConstColors.black,
              borderRadius: BorderRadius.circular(5),
            ),

            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

            child: PoppinsText(
              text: daylist[index],
              fontSize: Sizes.s10,
              fontWeight: TextWeight.semiBold,
              color: !select ? ConstColors.white : ConstColors.black,
            ),
          ),
        );
      }),
    );
  }
}
