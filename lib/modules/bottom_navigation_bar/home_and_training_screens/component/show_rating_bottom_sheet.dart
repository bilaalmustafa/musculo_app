import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/rating_star.dart';

class ShowRatingBottomSheet extends StatefulWidget {
  const ShowRatingBottomSheet({super.key});

  @override
  State<ShowRatingBottomSheet> createState() => _ShowRatingBottomSheetState();
}

class _ShowRatingBottomSheetState extends State<ShowRatingBottomSheet> {
  int selectedRating = 2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        spacing: Sizes.s16,
        children: [
          Container(height: 3, width: 30, color: ConstColors.secondary),

          PoppinsText(
            text: "Leave a Review",
            fontSize: Sizes.s20,
            fontWeight: TextWeight.semiBold,
          ),
          Divider(color: ConstColors.secondary, height: 2),
          CreatorListTile(),
          Divider(color: ConstColors.secondary, height: 2),
          PoppinsText(
            text: "Rate The Creator?",
            fontSize: Sizes.s20,
            fontWeight: TextWeight.semiBold,
          ),
          PoppinsText(
            text: "Give your rating of the creator & your review.",
            fontSize: Sizes.s14,
            fontWeight: TextWeight.regular,
            color: ConstColors.greyA1A1,
          ),

        RatingStars( selectedRating:selectedRating ,  onRatingSelected: (newvalue){
           setState(() {
                                    selectedRating = newvalue;
                                  });
        },),
          CustomTextField(title: "review"),
          Divider(color: ConstColors.secondary, height: 2),
          Row(
            spacing: Sizes.s10,
            children: [
              Expanded(
                child: CustomButton(
                  buttonText: "Cancel",
                  buttonColor: ConstColors.secondary,
                  textColor: ConstColors.black,
                ),
              ),
              Expanded(child: CustomButton(buttonText: "Submit")),
            ],
          ),
        ],
      ),
    );
  }
}


