import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class Transectionitem extends StatelessWidget {
  const Transectionitem({
    super.key,

    required this.amount,
    required this.date,

    required this.time,
  });

  final double amount;

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    final bool isGain = amount >= 0;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: ConstColors.secondary,
          maxRadius: 25,
          child: SharePicture(imagePath: Assets.tWallet),
        ),
        const SizedBox(width: 16),
        // Transaction Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsText(
                text: isGain ? 'Subscription' : 'Cancelation',
                fontSize: Sizes.s16,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  PoppinsText(
                    text: date,
                    fontSize: Sizes.s13,
                    fontWeight: TextWeight.regular,
                  ),
                  SizedBox(
                    height: 15,
                    child: VerticalDivider(
                      thickness: 1.5,
                      width: 10,
                      color: Colors.grey,
                    ),
                  ),
                  PoppinsText(
                    text: time,
                    fontSize: Sizes.s13,
                    fontWeight: TextWeight.regular,
                  ),
                ],
              ),
            ],
          ),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PoppinsText(
              text:
                  isGain
                      ? '\$${amount.toStringAsFixed(0)}'
                      : '-\$${amount.abs().toStringAsFixed(0)}',
              fontSize: Sizes.s16,
              fontWeight: FontWeight.w600,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PoppinsText(
                  text: isGain ? 'Gain' : 'Loss',
                  fontSize: Sizes.s13,
                  fontWeight: TextWeight.regular,
                ),
                SizedBox(width: 4),
                SharePicture(
                  imagePath: isGain ? Assets.downSquare : Assets.rdownSquare,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
