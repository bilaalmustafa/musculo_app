import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? titleColor;
  final double? titleFont;
  final FontWeight? titleFontweight;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Sizes.s16,
      vertical: Sizes.s12,
    ),
    this.borderRadius = 12.0,
    this.titleColor,
    this.titleFont,
    this.titleFontweight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            if (leading != null) ...[leading!, SizedBox(width: Sizes.s12)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(
                    text: title,
                    fontSize: Sizes.s16,
                    color: titleColor ?? ConstColors.black,
                    fontWeight: TextWeight.medium,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: Sizes.s4),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[SizedBox(width: 12), trailing!],
          ],
        ),
      ),
    );
  }
}
