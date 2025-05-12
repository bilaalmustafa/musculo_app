import 'package:flutter/material.dart';

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
          label: Text(
            optionslist[index],
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
          selected: isSelected,
          selectedColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.black),
          ),
          onSelected: (selected) {
            onSelect(index);
          },
        );
      }),
    );
  }
}
