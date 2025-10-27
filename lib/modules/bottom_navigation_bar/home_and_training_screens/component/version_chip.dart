import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class VersionChip extends StatelessWidget {
  const VersionChip({
    super.key,
    this.onTap,
    required this.text,
    required this.btncolor,
    required this.txtcolor,
  });
  final VoidCallback? onTap;
  final String text;
  final Color btncolor, txtcolor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        height: Sizes.s40,
      
        decoration: BoxDecoration(
          color: btncolor,
          borderRadius: BorderRadius.circular(Sizes.s10),
        ),
        child: PoppinsText(
          text: text,
          fontSize: Sizes.s13,
          color: txtcolor,
          fontWeight: TextWeight.medium,
        ),
      ),
    );
  }
}
