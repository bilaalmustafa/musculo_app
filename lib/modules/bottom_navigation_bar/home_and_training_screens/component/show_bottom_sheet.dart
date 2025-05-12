import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/video_item.dart';

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.s20, vertical: Sizes.s8),
      height: 600,
      decoration: BoxDecoration(
        color: ConstColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),

      child: Column(
        spacing: Sizes.s20,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 4, width: 50, color: ConstColors.secondary),
          PoppinsText(
            text: "Choose Program",
            fontSize: Sizes.s20,
            fontWeight: TextWeight.semiBold,
            color: ConstColors.black,
          ),
          Divider(color: ConstColors.secondary, thickness: 2),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => VideoItem(),
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
          ),

          Divider(color: ConstColors.secondary, thickness: 2),
          Row(
            spacing: Sizes.s10,
            children: [
              Expanded(
                child: CustomButton(
                  buttonText: "Back",
                  buttonColor: ConstColors.secondary,
                  textColor: ConstColors.black,
                ),
              ),
              Expanded(
                child: CustomButton(
                  buttonText: "Start",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.trainingscreen);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: Sizes.s5),
        ],
      ),
    );
  }
}
