import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/video_item.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../../../../core/config/routes.dart';
import '../../../../core/constants/sizes.dart';

class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Programs'),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          spacing: Sizes.s20,
          children: [
            CustomTextField(
              preIcon: Assets.searchIcon,
              title: 'Search Program',
              sufIcon: Assets.filterIcon,
              onTap: () {
                Navigator.pushNamed(context, Routes.filterscreen);
              },
            ),
            VideoItem(
              creatorName: 'Asim khan',
              programTitle: 'Quick Core Blaster',
              radiostatus: true,
            ),
            VideoItem(
              creatorName: 'Creator Name',
              programTitle: 'Weight Lifting',
            ),
            VideoItem(creatorName: 'Creator Name', radiostatus: true),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: CustomButton(
          onTap: () {
            // navigation handle here
            Navigator.pushNamed(
              context,
              Routes.feedbScreen,
              arguments: {'feedbackType': 'Program'},
            );
          },

          buttonText: 'Continue',
        ),
      ),
    );
  }
}
