import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/program_video_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/workout_video_items.dart';

class ShowBottomSheet extends StatefulWidget {
  final String? title;
  final dynamic modelData;
  const ShowBottomSheet({super.key, this.title, this.modelData});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.s20, vertical: Sizes.s8),
      height: 500,
      decoration: BoxDecoration(
        color: ConstColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.s32)),
      ),
      child: Column(
        children: [
          Container(
            height: Sizes.s4,
            width: Sizes.s50,
            color: ConstColors.secondary,
          ),
          SizedBox(height: 10),
          PoppinsText(
            text: widget.title ?? '',
            fontSize: Sizes.s20,
            fontWeight: TextWeight.semiBold,
            color: ConstColors.black,
          ),
          SizedBox(height: 10),
          Divider(color: ConstColors.secondary, thickness: 2),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: widget.modelData.length,
              itemBuilder:
                  (context, index) =>
                      widget.title == "Choose Workout"
                          ? WorkoutVideoItem(
                            index: index,
                            selectedIndex: selectedIndex,
                            workouts: widget.modelData[index],
                            onChanged: (val) {
                              setState(() {
                                selectedIndex = val;
                              });
                            },
                            // programTitle: "Program $index",
                            // programTime: "15 Mins",
                            // programStatus: "Beginner",
                            // creatorName: "Trainer $index",
                          )
                          : ProgramVideoItem(
                            index: index,
                            selectedIndex: selectedIndex,
                            program: widget.modelData[index],
                            onChanged: (val) {
                              setState(() {
                                selectedIndex = val;
                              });
                            },
                            // programTitle: "Program $index",
                            // programTime: "15 Mins",
                            // programStatus: "Beginner",
                            // creatorName: "Trainer $index",
                          ),
              separatorBuilder: (_, __) => SizedBox(height: Sizes.s20),
            ),
          ),
          Divider(color: ConstColors.secondary, thickness: 2),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  buttonText: "Back",
                  buttonColor: ConstColors.secondary,
                  textColor: ConstColors.black,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Expanded(
                child: CustomButton(
                  buttonText: "Start",
                  onTap: () {
                    if (selectedIndex != null) {
                      Navigator.pushNamed(context, Routes.trainingscreen);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a program"),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
