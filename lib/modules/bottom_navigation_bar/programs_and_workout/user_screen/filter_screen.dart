import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/chips.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/rang_slider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> options = [
    "All",
    "With Equipment",
    "Without Equipment",
    "Stretching",
  ];
  final List<String> gender = ["All", "Male", "Female"];
  final List<String> premium = ["Premium only "];
  int selectedIndex = 0, genderSelect = 0, premiumSelect = 0;
  double sliderValue = 0;
  RangeValues _priceRange = RangeValues(0, 500);
  RangeValues _timeRange = RangeValues(1.0, 60.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: "Filter"),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Sizes.s20,
            children: [
              PoppinsText(
                text: "Plan Type",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              CustomChips(
                selectedIndex: selectedIndex,
                optionslist: options,
                onSelect:
                    (value) => setState(() {
                      selectedIndex = value;
                    }),
              ),
              PoppinsText(
                text: "Gender",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              CustomChips(
                selectedIndex: genderSelect,
                optionslist: gender,
                onSelect:
                    (value) => setState(() {
                      genderSelect = value;
                    }),
              ),
              PoppinsText(
                text: "Creators",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              CustomChips(
                selectedIndex: premiumSelect,
                optionslist: premium,
                onSelect:
                    (value) => setState(() {
                      genderSelect = value;
                    }),
              ),
              PoppinsText(
                text: "Price",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              RangSliders(
                min: 0,
                max: 500,
                type: "£",
                currentRange: _priceRange,
                valuechange:
                    (value) => setState(() {
                      _priceRange = value;
                    }),
              ),
              PoppinsText(
                text: "Time Length",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              RangSliders(
                min: 1.0,
                max: 60,
                type: "min",
                currentRange: _timeRange,
                valuechange:
                    (value) => setState(() {
                      _timeRange = value;
                    }),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Slider(
                    min: 0,
                    max: 10,
                    activeColor: ConstColors.black,
                    inactiveColor: ConstColors.secondary,
                    value: sliderValue,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                  PoppinsText(
                    text: sliderValue.round().toString(),
                    fontSize: Sizes.s12,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 20),
        child: Row(
          spacing: Sizes.s10,
          children: [
            Expanded(
              child: CustomButton(
                buttonText: "Cancel",
                buttonColor: ConstColors.secondary,
                textColor: ConstColors.black,
              ),
            ),
            Expanded(child: CustomButton(buttonText: "Apply")),
          ],
        ),
      ),
    );
  }
}
