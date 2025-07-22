import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/rating_star.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_view_model.dart';
import 'package:provider/provider.dart';

class ShowrateSheet extends StatefulWidget {
  const ShowrateSheet({super.key, required this.workoutModel});
  final WorkoutModel workoutModel;
  @override
  State<ShowrateSheet> createState() => _ShowrateSheetState();
}

class _ShowrateSheetState extends State<ShowrateSheet> {
  TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.workoutModel;

    String formatProgramTime(int totalTimeInSeconds) {
      int totalMinutes = totalTimeInSeconds ~/ 60;

      if (totalMinutes < 60) {
        return "$totalMinutes Mins";
      } else {
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;

        // Round up to the next hour if minutes >= 45
        if (minutes >= 45) {
          hours += 1;
        }

        return "$hours Hr";
      }
    }

    return FractionallySizedBox(
      heightFactor: 1,

      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ChangeNotifierProvider(
          create: (context) => DiscoverViewModel(),
          child: SingleChildScrollView(
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
                    color: ConstColors.black,
                    // borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: ConstColors.gre9E9E),
                    shape: BoxShape.circle,
                    // image: DecorationImage(image: AssetImage(Assets.workout)),
                  ),
                  child: Center(
                    child: PoppinsText(
                      text: data.creatorName![0].toUpperCase(),
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: ConstColors.white,
                    ),
                  ),
                ),
                PoppinsText(
                  text: data.workoutName ?? "unknown",
                  fontSize: Sizes.s16,
                  fontWeight: TextWeight.semiBold,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: Sizes.s10,
                  children: [
                    CustomChip(
                      text: formatProgramTime(data.totalTime ?? 0),
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
                  text: "How is your Workout?",
                  fontSize: Sizes.s20,
                  fontWeight: TextWeight.semiBold,
                ),
                PoppinsText(
                  text: "Give your rating of the Workout & your reviews",
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
                              WorkoutModel? success = await vm
                                  .postWorkoutRatingAndReview(
                                    data.workoutId!,
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
