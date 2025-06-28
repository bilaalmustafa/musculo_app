import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/rating_star.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_view_model.dart';
import 'package:provider/provider.dart';

class ShowRatingBottomSheet extends StatefulWidget {
  const ShowRatingBottomSheet({super.key});

  @override
  State<ShowRatingBottomSheet> createState() => _ShowRatingBottomSheetState();
}

class _ShowRatingBottomSheetState extends State<ShowRatingBottomSheet> {
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final creatorVm = context.read<UserViewModel>();
    final data = creatorVm.userModel;
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
            textAlign: TextAlign.center,
          ),

          Consumer<UserViewModel>(
            builder: (context, vm, _) {
              return RatingStars(
                selectedRating: vm.selectedRating,
                onRatingSelected: (newvalue) {
                  vm.selectStart(newvalue);
                },
              );
            },
          ),
          CustomTextField(controller: reviewController, title: "Amazing"),
          Divider(color: ConstColors.secondary, height: 2),
          Row(
            spacing: Sizes.s10,
            children: [
              Expanded(
                child: CustomButton(
                  buttonText: "Cancel",
                  buttonColor: ConstColors.secondary,
                  textColor: ConstColors.black,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: Consumer<UserViewModel>(
                  builder: (context, vm, _) {
                    return CustomButton(
                      loading: vm.isLoading,
                      onTap: () async {
                        double newRating = vm.getingRating(
                          data?.rating ?? 0.0,
                          data?.countRating ?? 0,
                        );
                        final List<String> reviewList = List.from(
                          data?.review ?? [],
                        );
                        if (reviewController.text.isNotEmpty) {
                          reviewList.add(reviewController.text);
                        }
                        UserModel? success = await vm
                            .postCreatorRatingAndReview(
                              data?.userId ?? "",
                              newRating,
                              (data?.countRating ?? 0) + 1,
                              data!,
                              reviewList,
                            );
                        if (success != null && context.mounted) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }
                      },
                      buttonText: "Submit",
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
