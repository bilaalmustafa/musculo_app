import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
  });
  final int selectedRating;
  final Function(int) onRatingSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Sizes.s20,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingSelected(index + 1),
          child: Icon(
            index < selectedRating ? Icons.star : Icons.star_border,
            color: ConstColors.orange,

            size: Sizes.s32,
          ),
        );
      }),
    );
  }
}
