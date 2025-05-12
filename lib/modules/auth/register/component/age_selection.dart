import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SelectAge extends StatelessWidget {
  final int index;
  final bool isSelected; // Add this parameter to control the underline

  const SelectAge({super.key, required this.index, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 4,
              color: Colors.black, // Change the color as needed
              width: Sizes.s60, // Adjust the width to fit your needs
            ),

          Text(
            '$index',
            style: TextStyle(
              fontSize: Sizes.s40,
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),

          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 4,
              color: Colors.black, // Change the color as needed
              width: Sizes.s60, // Adjust the width to fit your needs
            ),
        ],
      ),
    );
  }
}
