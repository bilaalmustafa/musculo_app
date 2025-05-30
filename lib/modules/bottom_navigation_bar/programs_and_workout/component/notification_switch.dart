import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/const_colors.dart';

class NotificationSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool useCupertino; // Toggle between Material and Cupertino
  final double scale;

  const NotificationSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.useCupertino = false,
    this.scale = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    final Widget switchWidget =
        useCupertino
            ? CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: ConstColors.green4AD,
              inactiveTrackColor: ConstColors.greyEEE,
            )
            : Switch(
              activeColor: ConstColors.white,
              activeTrackColor: ConstColors.green4AD,
              inactiveTrackColor: ConstColors.greyEEE,
              inactiveThumbColor: ConstColors.white,
              value: value,
              onChanged: onChanged,
            );

    return Transform.scale(scale: scale, child: switchWidget);
  }
}
