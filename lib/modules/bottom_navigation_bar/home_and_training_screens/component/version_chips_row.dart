import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/version_chip.dart';

class VersionChipsRow extends StatelessWidget {
  const VersionChipsRow({
    super.key,
    required this.selectedindex,
    required this.onSelected,
  });
  final int selectedindex;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) {
    List<String> versions = ["version 01", "version 02", "version 03"];
    return Container(
      height: Sizes.s40,
      width: double.infinity,
      color: ConstColors.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(versions.length, (index) {
          final isSelected = index == selectedindex;
          return VersionChip(
            text: versions[index],
            btncolor: isSelected ? ConstColors.black : ConstColors.secondary,
            txtcolor: isSelected ? ConstColors.white : ConstColors.black,
            onTap: () => onSelected(index),
          );
        }),
      ),
    );
  }
}
