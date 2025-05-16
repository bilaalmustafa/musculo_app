import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/analysis_listtile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/creator_List_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/day_chip.dart';

class CreatorModeTab extends StatefulWidget {
  const CreatorModeTab({super.key});

  @override
  State<CreatorModeTab> createState() => _CreatorModeTabState();
}

class _CreatorModeTabState extends State<CreatorModeTab> {
  int selectTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: ConstColors.black,

            child: Column(
              spacing: Sizes.s10,

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PoppinsText(
                  text: "\$ 2,300",
                  fontSize: Sizes.s30,
                  color: ConstColors.white,
                  fontWeight: TextWeight.semiBold,
                ),
                PoppinsText(
                  text: "Balance Available",
                  fontSize: Sizes.s10,
                  color: ConstColors.white,
                  fontWeight: TextWeight.regular,
                ),
                DaysChip(
                  daylist: ["1D", "1W", "1M", "3M", "1Y"],
                  selectTab: selectTab,
                  onTap: (index) {
                    setState(() {
                      selectTab = index;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  children: [
                    AnalysisLisTile(
                      heading1: "Total sales",
                      heading2: "50",
                      icon: Icons.analytics,
                    ),
                    AnalysisLisTile(
                      heading1: "Cancelled",
                      heading2: "12",
                      icon: Icons.cancel_outlined,
                    ),
                  ],
                ),

                Row(
                  children: [
                    AnalysisLisTile(
                      heading1: "Ratings",
                      heading2: "4.0",
                      icon: Icons.star,
                    ),

                    AnalysisLisTile(
                      heading1: "Withdrawed",
                      heading2: "\$600",
                      icon: Icons.credit_card,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoppinsText(
                      text: "Your Programs",
                      fontSize: Sizes.s20,
                      fontWeight: TextWeight.semiBold,
                      color: ConstColors.black,
                    ),
                    PoppinsText(
                      text: "See All",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                      color: ConstColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CreatorListItems();
              },
              separatorBuilder: (_, index) {
                return SizedBox(height: Sizes.s20);
              },
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
