import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/planlisttile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/routes.dart';
import '../../home_and_training_screens/view_model/user_view_model.dart';

class BecomecreatorScreen extends StatefulWidget {
  const BecomecreatorScreen({super.key});

  @override
  State<BecomecreatorScreen> createState() => _BecomecreatorScreenState();
}

class _BecomecreatorScreenState extends State<BecomecreatorScreen> {
  @override
  Widget build(BuildContext context) {
    final userVm = context.watch<UserViewModel>();
    final data = userVm.userModel;

    bool isplaneSelected = data?.subPlane == "free" ? true : false;
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Become a Creator'),

      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: SingleChildScrollView(
          child: Consumer<ProfileProvider>(
            builder: (context, vm, _) {
              return Column(
                spacing: Sizes.s20,
                children: [
                  GestureDetector(
                    onTap: () {
                      vm.selectPlane(0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              vm.selectPlan == 0
                                  ? ConstColors.black
                                  : ConstColors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.s8),
                        child: Column(
                          children: [
                            SizedBox(height: Sizes.s10),
                            PoppinsText(
                              text: 'Basic',
                              fontSize: Sizes.s16,
                              fontWeight: FontWeight.w600,
                            ),
                            PoppinsText(
                              text: 'Free',
                              fontSize: Sizes.s40,
                              fontWeight: FontWeight.w600,
                            ),
                            Divider(
                              height: Sizes.s1,
                              color: ConstColors.greyE5E5,
                            ),
                            PlanListTile(text: 'Sell workouts'),
                            PlanListTile(text: 'Sell programs'),
                            PlanListTile(text: 'Access to all exercises'),
                            PlanListTile(text: 'Create up to 10 workouts'),
                            PlanListTile(text: 'Create up to 10 programs'),
                            PlanListTile(text: 'basic customer service'),
                            SizedBox(height: Sizes.s10),
                            Divider(
                              height: Sizes.s1,
                              color: ConstColors.greyE5E5,
                            ),
                            SizedBox(height: Sizes.s10),
                            PoppinsText(
                              text: isplaneSelected ? 'Your Current Plan' : '',
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
                      vm.selectPlane(1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(Sizes.s12),
                        border: Border.all(
                          color:
                              vm.selectPlan == 1
                                  ? ConstColors.black
                                  : ConstColors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.s8),
                        child: Column(
                          children: [
                            SizedBox(height: Sizes.s10),
                            PoppinsText(
                              text: 'Premium',
                              fontSize: Sizes.s16,
                              fontWeight: FontWeight.w600,
                            ),
                            PoppinsText(
                              text: '€9.99',
                              fontSize: Sizes.s40,
                              fontWeight: FontWeight.w600,
                            ),
                            Divider(
                              height: Sizes.s1,
                              color: ConstColors.greyE5E5,
                            ),
                            PlanListTile(text: 'Sell workouts'),
                            PlanListTile(text: 'Sell Programs'),
                            PlanListTile(text: 'Access to all excercises'),
                            PlanListTile(text: 'NO ADS'),
                            PlanListTile(text: 'UNLIMITED workouts to create'),
                            PlanListTile(text: 'UNLIMITED programs to create'),
                            PlanListTile(text: 'with PREMIUM badge'),
                            PlanListTile(text: 'PRIORITY in searching'),
                            PlanListTile(text: 'PRIORITY customer service'),
                            PlanListTile(
                              text:
                                  'Exclusive access to new features and content',
                            ),

                            SizedBox(height: Sizes.s10),
                            Divider(
                              height: Sizes.s1,
                              color: ConstColors.greyE5E5,
                            ),
                            SizedBox(height: Sizes.s10),
                            PoppinsText(
                              text: isplaneSelected ? "" : 'Your Current Plan',
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
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Sizes.s16),
        child: Consumer<ProfileProvider>(
          builder: (context, vm, _) {
            return CustomButton(
              onTap:
                  vm.selectPlan != null
                      ? () {
                        Navigator.pushNamed(context, Routes.creatorInfoScreen);
                      }
                      : null,

              buttonText: 'Continues',
            );
          },
        ),
      ),
    );
  }
}
