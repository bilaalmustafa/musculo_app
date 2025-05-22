import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart' show TextWeight;
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/rating_star.dart';

class ShowrateBottomSheet extends StatefulWidget {
  const ShowrateBottomSheet({super.key});

  @override
  State<ShowrateBottomSheet> createState() => _ShowrateBottomSheetState();
}

class _ShowrateBottomSheetState extends State<ShowrateBottomSheet> {
  int selectedRating = 2;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 20),
        child: Column(
          spacing: Sizes.s8,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: 5,
                width: 40,
                color: ConstColors.dividerColor,
              ),
            ),
            PoppinsText(
              text: "Leave a Review",
              fontSize: Sizes.s20,
              fontWeight: TextWeight.semiBold,
            ),
            Divider(color: ConstColors.dividerColor),
            Container(
              height: Sizes.s110,
              width: Sizes.s110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: AssetImage(Assets.workout)),
              ),
            ),
            PoppinsText(
              text: "Powerlift",
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Sizes.s10,
              children: [
                CustomChip(text: "5 week", color: ConstColors.secondary),
                CustomChip(text: "Beginner", color: ConstColors.secondary),
              ],
            ),
            Divider(color: ConstColors.dividerColor),
            PoppinsText(
              text: "How is your program?",
              fontSize: Sizes.s20,
              fontWeight: TextWeight.semiBold,
            ),
            PoppinsText(
              text: "Give your rating of the program & your reviews",
              fontSize: Sizes.s12,
              color: ConstColors.greyA1A1,
            ),
            RatingStars(
              selectedRating: selectedRating,
              onRatingSelected: (newvalue) {
                setState(() {
                  selectedRating = newvalue;
                });
              },
            ),
            CustomTextField(title: "Amazing"),
            SizedBox(height: Sizes.s20),
            Row(
              spacing: Sizes.s10,
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: "Cancel",
                    buttonColor: ConstColors.secondary,
                    textColor: ConstColors.black,
                    onTap: () => Navigator.pop(context),
                  ),
                ),

                Expanded(child: CustomButton(buttonText: "Submit")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
