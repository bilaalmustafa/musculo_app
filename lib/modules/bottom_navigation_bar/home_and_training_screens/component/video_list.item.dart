import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    required this.tumbnail,
  });

  final int index;
  final int selectedIndex;
  final VoidCallback onTap;
  final Uint8List? tumbnail;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: Sizes.s80,
            height: Sizes.s80,
            decoration: BoxDecoration(
              color: ConstColors.secondary,
              borderRadius: BorderRadius.circular(Sizes.s10),
              border: Border.all(
                color:
                    isSelected ? ConstColors.primary0769 : Colors.transparent,
                width: 2,
              ),
              // image: DecorationImage(
              //   image:

              //           ?
              //           : AssetImage(Assets.workout),
              //   fit: BoxFit.cover,
              // ),
            ),
            child:
                tumbnail != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.s10),
                      child: Image.memory(tumbnail!, fit: BoxFit.fill),
                    )
                    : SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(),
                    ),
          ),
          isSelected
              ? Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 16,
                  width: 16,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ConstColors.primary0769,
                    borderRadius: BorderRadius.circular(Sizes.s2),
                  ),
                  child: Icon(Icons.check, size: 12, color: Colors.white),
                ),
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
