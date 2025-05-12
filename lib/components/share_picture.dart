import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SharePicture extends StatelessWidget {
  const SharePicture({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    final issSvg = imagePath.toLowerCase().endsWith('.svg');
    return issSvg
        ? SvgPicture.asset(imagePath, width: width, height: height, fit: fit)
        : Image.asset(imagePath, width: width, height: height, fit: fit);
  }
}
