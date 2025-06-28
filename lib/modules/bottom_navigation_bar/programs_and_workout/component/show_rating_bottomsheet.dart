import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/rating_star.dart';
import 'package:provider/provider.dart';

import '../screen/view_model/discover_view_model.dart';

class ShowrateBottomSheet extends StatefulWidget {
  const ShowrateBottomSheet({super.key, required this.programModel});
  final ProgramModel programModel;
  @override
  State<ShowrateBottomSheet> createState() => _ShowrateBottomSheetState();
}

class _ShowrateBottomSheetState extends State<ShowrateBottomSheet> {
  TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.programModel;
    String getWeeksFromDuration(int? durationInDays) {
      if (durationInDays == null || durationInDays <= 0) return "0";

      if (durationInDays < 7) return "1";

      final weeks = (durationInDays / 7).ceil();
      return weeks.toString();
    }

    return ChangeNotifierProvider(
      create: (context) => DiscoverViewModel(),
      child: FractionallySizedBox(
        heightFactor: 1,
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: Sizes.s8,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 4,
                  width: 40,
  decoration: BoxDecoration(
                    color: ConstColors.dividerColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                child:   Expanded(
                    child: Consumer<DiscoverViewModel>(
                      builder: (context, vm, _) {
                        return CustomButton(
                          loading: vm.isloading,
                          onTap: () async {
                            double newRating = vm.getingRating(
                              data.rating ?? 0.0,
                              data.ratingCount ?? 0,
                            );
                            final List<String> reviewList = List.from(
                              data.review ?? [],
                            );
                            if (reviewController.text.isNotEmpty) {
                              reviewList.add(reviewController.text);
                            }
                            ProgramModel? success = await vm
                                .postProgramRatingAndReview(
                                  data.programId!,
                                  newRating,
                                  (data.ratingCount ?? 0) + 1,
                                  data,
                                  reviewList,
                                );
                            if (success != null && context.mounted) {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            }
                          },
                          buttonText: "Submit",
                        );
                      },
                    ),
                
                ),),
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
                  text: data.programName ?? "unknown",
                  fontSize: Sizes.s16,
                  fontWeight: TextWeight.semiBold,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: Sizes.s10,
                  children: [
                    CustomChip(
                      text: "${getWeeksFromDuration(data.duration)} week",
                      color: ConstColors.secondary,
                    ),
                    CustomChip(
                      text: data.levelOf ?? "unknown",
                      color: ConstColors.secondary,
                    ),
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
                Consumer<DiscoverViewModel>(
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

                    Expanded(
                      child: Consumer<DiscoverViewModel>(
                        builder: (context, vm, _) {
                          return CustomButton(
                            loading: vm.isloading,
                            onTap: () async {
                              double newRating = vm.getingRating(
                                data.rating ?? 0.0,
                                data.ratingCount ?? 0,
                              );
                              final List<String> reviewList = List.from(
                                data.review ?? [],
                              );
                              if (reviewController.text.isNotEmpty) {
                                reviewList.add(reviewController.text);
                              }
                              ProgramModel? success = await vm
                                  .postProgramRatingAndReview(
                                    data.programId!,
                                    newRating,
                                    (data.ratingCount ?? 0) + 1,
                                    data,
                                    reviewList,
                                  );
                              if (success != null && context.mounted) {
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                              }
                            },
                            buttonText: "Submit",
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
