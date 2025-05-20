import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

class CounterContainer extends StatelessWidget {
  CounterContainer({
    super.key,
    this.boxColor,
    required this.increment,
    required this.decreament,
    required this.min,
    required this.sec,
  });
  Color? boxColor;
  final int min, sec;
  final VoidCallback increment, decreament;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: boxColor != null ? ConstColors.white : ConstColors.black,
        borderRadius: BorderRadius.circular(8),
      ),

      child: Row(
        spacing: 8,
        children: [
          GestureDetector(
            onTap: increment,
            child: Icon(
              Icons.remove,
              color: boxColor == null ? ConstColors.white : ConstColors.black,
              size: 18,
            ),
          ),
          PoppinsText(
            text: "0$min:0$sec",
            fontSize: 12,
            color: boxColor == null ? ConstColors.white : ConstColors.black,
          ),
          GestureDetector(
            onTap: decreament,
            child: Icon(
              Icons.add,
              color: boxColor == null ? ConstColors.white : ConstColors.black,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
