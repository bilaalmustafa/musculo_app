import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.width = double.infinity,
    required this.height,
  });

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ConstColors.secondary,
      highlightColor: ConstColors.white,
      child: Container(
        decoration: BoxDecoration(
          color: ConstColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        width: width,
        height: height,
      ),
    );
  }
}
