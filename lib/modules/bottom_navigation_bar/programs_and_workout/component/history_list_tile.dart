import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class HistoryListTile extends StatelessWidget {
  const HistoryListTile({
    super.key,
    required this.headingtext,
    required this.runtext,
    required this.timetext,
  });
  final String headingtext, runtext, timetext;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: PoppinsText(
        text: headingtext,
        fontSize: Sizes.s14,
        fontWeight: TextWeight.semiBold,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SharePicture(
            imagePath: Assets.runnerIcon,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(ConstColors.red, BlendMode.srcIn),
          ),
          SizedBox(width: 1),
          PoppinsText(
            text: runtext,
            fontSize: Sizes.s12,
            fontWeight: TextWeight.medium,
          ),
          SizedBox(width: Sizes.s8),
          SharePicture(
            imagePath: Assets.timeCircle,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              ConstColors.green4AD,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 1),
          PoppinsText(
            text: "$timetext mins",
            fontSize: Sizes.s12,
            fontWeight: TextWeight.medium,
          ),
        ],
      ),
    );
  }
}
