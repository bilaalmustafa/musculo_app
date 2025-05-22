import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/video_item.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../../../../core/config/routes.dart';
import '../../../../core/constants/sizes.dart';

class ProgramScreen extends StatefulWidget {
  const ProgramScreen({super.key});

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  int? selectedIndex;
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
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                itemBuilder:
                    (context, index) => VideoItem(
                      index: index,
                      selectedIndex: selectedIndex,
                      onChanged: (val) {
                        setState(() {
                          selectedIndex = val;
                        });
                      },
                      programTitle: "Quick Core Blaster",
                      // programTime: "15 Mins",
                      // programStatus: "Beginner",
                      creatorName: "Ceator name",
                    ),
                separatorBuilder: (_, __) => SizedBox(height: Sizes.s20),
              ),
            ),
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
