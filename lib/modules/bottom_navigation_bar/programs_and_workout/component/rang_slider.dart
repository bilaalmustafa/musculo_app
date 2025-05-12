import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

class RangSliders extends StatelessWidget {
  const RangSliders({
    super.key,
    required this.currentRange,
    required this.valuechange,
    required this.min,
    required this.max,
    required this.type,
  });
  final RangeValues currentRange;
  final ValueChanged valuechange;
  final double min, max;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4.0,
            activeTrackColor: ConstColors.black,
            inactiveTrackColor: ConstColors.secondary,
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: ConstColors.white.withAlpha(32),
            thumbColor: ConstColors.black,
          ),
          child: RangeSlider(
            values: currentRange,
            min: min,
            max: max,

            // labels: RangeLabels(
            //   "${currentRange.start.round().toString()} \$",
            //   currentRange.end.round().toString(),
            // ),
            onChanged: (RangeValues values) {
              valuechange(values);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PoppinsText(
              text: "${currentRange.start.round()} $type",
              fontSize: 12,
            ),
            PoppinsText(
              text: "${currentRange.end.round()} $type",
              fontSize: 12,
            ),
          ],
        ),
      ],
    );
  }
}
