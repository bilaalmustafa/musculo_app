import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
// ignore: unused_import
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/chips.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/rang_slider.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_filter_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    // Sync temp values with current applied values
    Future.microtask(() {
      context.read<DiscoverFilter>().resetTemp();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = context.watch<DiscoverFilter>();
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: "Filter"),

      body: Padding(
        padding: const EdgeInsets.all(Sizes.s20),
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
                selectedIndex: filtered.tempPlanType,
                optionslist: options,
                onSelect: (value) => filtered.setTempPlanType(value),
              ),
              PoppinsText(
                text: "Gender",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              CustomChips(
                selectedIndex: filtered.tempGender,
                optionslist: gender,
                onSelect: (value) => filtered.setTempGender(value),
              ),
              PoppinsText(
                text: "Creators",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
              ),
              CustomChips(
                selectedIndex: filtered.tempPremium ? 0 : -1,
                optionslist: premium,
                onSelect: (_) => filtered.setTempPremium(!filtered.premium),
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
                currentRange: filtered.tempPrice,
                valuechange: (value) => filtered.setTempPrice(value),
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
                currentRange: filtered.tempLength,
                valuechange: (value) => filtered.setTempLength(value),
              ),
              PoppinsText(
                text: "Difficulty",
                fontSize: Sizes.s16,
                fontWeight: TextWeight.semiBold,
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
                    value: filtered.tempDifficulty,
                    onChanged: filtered.setTempDifficulty,
                  ),
                  PoppinsText(
                    text: filtered.tempDifficulty.round().toString(),
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
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: CustomButton(
                buttonText: "Apply",
                onTap: () {
                  // apply button code here
                  filtered.applyFilters();
                  filtered.applyFilterFlag();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
