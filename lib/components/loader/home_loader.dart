import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class HomeLoader extends StatefulWidget {
  const HomeLoader({super.key});

  @override
  State<HomeLoader> createState() => _HomeLoaderState();
}

class _HomeLoaderState extends State<HomeLoader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),

      child: SingleChildScrollView(
        child: Column(
          spacing: Sizes.s20,
          children: [
            CustomTextField(
              title: "Search program",
              // prefexicon: Icons.search,
              preIcon: Assets.searchIcon,
              sufIcon: Assets.filterIcon,

              // suffexicon: Icons.filter_list_outlined,
            ),
            CustomShimmer(height: 200),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoppinsText(
                  text: "Top Programs",
                  fontSize: Sizes.s18,
                  fontWeight: TextWeight.semiBold,
                  color: ConstColors.black,
                ),
                PoppinsText(
                  text: "See All",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                  color: ConstColors.black,
                ),
              ],
            ),
            CustomShimmer(height: 200),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoppinsText(
                  text: "Your Programs",
                  fontSize: Sizes.s18,
                  fontWeight: TextWeight.semiBold,
                  color: ConstColors.black,
                ),
                PoppinsText(
                  text: "See All",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                  color: ConstColors.black,
                ),
              ],
            ),

            ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CustomShimmer(height: 80),
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoppinsText(
                  text: "Your Worouts",
                  fontSize: Sizes.s18,
                  fontWeight: TextWeight.semiBold,
                  color: ConstColors.black,
                ),
                PoppinsText(
                  text: "See All",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                  color: ConstColors.black,
                ),
              ],
            ),

            ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CustomShimmer(height: 80),
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
