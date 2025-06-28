import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class Transectionitem extends StatelessWidget {
  const Transectionitem({super.key, required this.amount, required this.date, required this.isGain});

  final double amount;
  final bool isGain;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMM dd, yyyy').format(date);
    final String formattedTime = DateFormat('hh:mm a').format(date);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: ConstColors.secondary,
          maxRadius: 25,
          child: SharePicture(imagePath: Assets.tWallet),
        ),
        const SizedBox(width: Sizes.s16),
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
                    text: formattedDate,
                    fontSize: Sizes.s13,
                    fontWeight: TextWeight.regular,
                  ),
                  SizedBox(
                    height: Sizes.s15,
                    child: VerticalDivider(
                      thickness: 1.5,
                      width: Sizes.s10,
                      color: Colors.grey,
                    ),
                  ),
                  PoppinsText(
                    text: formattedTime,
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
