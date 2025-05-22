import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
// Import the reusable widget

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.buttonWidth = double.infinity,
    this.buttonHeight = Sizes.s50,
    this.buttonColor = ConstColors.black,
    this.textColor = ConstColors.white,
    this.onTap,
    this.preIconData,
    this.preSvgPath,
    this.postIconData,
    this.postSvgPath,
    this.loading = false,
  });

  final String buttonText;
  final double buttonWidth, buttonHeight;
  final Color buttonColor, textColor;
  final VoidCallback? onTap;
  final IconData? preIconData, postIconData;
  final String? preSvgPath, postSvgPath;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(Sizes.s10),
        ),
        child: Center(
          child:
              loading
                  ? CircularProgressIndicator(color: ConstColors.white)
                  : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BtnSharePicture(
                        iconData: preIconData,
                        svgPath: preSvgPath,
                        color: textColor,
                        size: Sizes.s24,
                      ),
                      const SizedBox(width: Sizes.s8),
                      PoppinsText(
                        text: buttonText,
                        fontSize: Sizes.s13,
                        color: textColor,
                        fontWeight: TextWeight.semiBold,
                      ),
                      const SizedBox(width: Sizes.s8),
                      BtnSharePicture(
                        iconData: postIconData,
                        svgPath: postSvgPath,
                        color: textColor,
                        size: Sizes.s24,
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}

class BtnSharePicture extends StatelessWidget {
  final IconData? iconData;
  final String? svgPath;
  final double size;
  final Color? color;

  const BtnSharePicture({
    super.key,
    this.iconData,
    this.svgPath,
    this.size = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      return Icon(iconData, size: 18, color: color);
    } else if (svgPath != null) {
      return SvgPicture.asset(
        svgPath!,
        height: 20,
        width: 20,
        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
      );
    } else {
      return const SizedBox.shrink(); // Empty container
    }
  }
}
