import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';

import '../../../../../../core/constants/sizes.dart';

class ShowSheetBottom extends StatelessWidget {
  const ShowSheetBottom({super.key, required this.listController});
  final List listController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.s16),
      child: Column(
        spacing: 10,
        children: [
          Container(
            height: 3,
            width: 40,
            decoration: BoxDecoration(
              color: ConstColors.greyC8C8,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          PoppinsText(
            text: "Add Versions",
            fontSize: Sizes.s18,
            fontWeight: TextWeight.semiBold,
          ),

          Divider(color: ConstColors.dividerColor),
          CustomTextField(
            title: "search exercise",
            preIcon: Assets.searchIcon,
            sufIcon: Assets.filterIcon,
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              color: ConstColors.secondary,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final controller = listController[index];
                  return ReelsItem(controller: controller);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 3,
              ),
            ),
          ),

          Divider(color: ConstColors.dividerColor),
          Container(
            color: ConstColors.white,

            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: "Back",
                    buttonColor: ConstColors.secondary,
                    textColor: ConstColors.black,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Expanded(child: CustomButton(buttonText: "Add")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
