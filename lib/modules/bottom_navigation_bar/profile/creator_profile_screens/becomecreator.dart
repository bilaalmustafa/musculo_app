import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/planlisttile.dart';

import '../../../../core/config/routes.dart';

class BecomecreatorScreen extends StatefulWidget {
  const BecomecreatorScreen({super.key});

  @override
  State<BecomecreatorScreen> createState() => _BecomecreatorScreenState();
}

class _BecomecreatorScreenState extends State<BecomecreatorScreen> {
  int? selectPlan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Become a Creator'),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: Sizes.s20,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectPlan = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          selectPlan == 0
                              ? ConstColors.black
                              : ConstColors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: Sizes.s10),
                        PoppinsText(
                          text: 'Normal',
                          fontSize: Sizes.s16,
                          fontWeight: FontWeight.w600,
                        ),
                        PoppinsText(
                          text: 'Free',
                          fontSize: Sizes.s40,
                          fontWeight: FontWeight.w600,
                        ),
                        Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
                        PlanListTile(
                          text:
                              'Access to a selection of basic workout programs.',
                        ),
                        PlanListTile(text: 'Sell programs'),
                        PlanListTile(text: 'Sell workouts'),
                        PlanListTile(text: 'Limited ad-supported experience'),
                        SizedBox(height: Sizes.s10),
                        Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
                        SizedBox(height: Sizes.s10),
                        PoppinsText(
                          text: 'Your Current Plan',
                          fontSize: Sizes.s16,
                          fontWeight: FontWeight.w600,
                          color: ConstColors.grey7575,
                        ),
                        SizedBox(height: Sizes.s10),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectPlan = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          selectPlan == 1
                              ? ConstColors.black
                              : ConstColors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: Sizes.s10),
                        PoppinsText(
                          text: 'Premium--',
                          fontSize: Sizes.s16,
                          fontWeight: FontWeight.w600,
                        ),
                        PoppinsText(
                          text: '\$9.99',
                          fontSize: Sizes.s40,
                          fontWeight: FontWeight.w600,
                        ),
                        Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
                        PlanListTile(text: 'Create up to 20 Workouts'),
                        PlanListTile(text: 'Create up to 20 Programs'),
                        PlanListTile(text: 'Sell workouts'),
                        PlanListTile(text: 'Sell programs'),
                        PlanListTile(text: 'Sell programs'),
                        PlanListTile(text: 'Ad-free experience.'),
                        PlanListTile(text: 'Program showed in search'),
                        PlanListTile(text: 'Diamond badge'),
                        PlanListTile(
                          text: 'Exclusive access to new features and content.',
                        ),
                        SizedBox(height: Sizes.s10),
                        Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
                        SizedBox(height: Sizes.s10),
                        PoppinsText(
                          text: 'Your Current Plan',
                          fontSize: Sizes.s16,
                          fontWeight: FontWeight.w600,
                          color: ConstColors.grey7575,
                        ),
                        SizedBox(height: Sizes.s10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: CustomButton(
          onTap:
              selectPlan != null
                  ? () {
                    // navigation handle here
                    Navigator.pushNamed(context, Routes.creatorInfoScreen);
                  }
                  : null,

          buttonText: 'Continues',
        ),
      ),
    );
  }
}
