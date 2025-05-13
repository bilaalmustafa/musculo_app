import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.s40),
          topRight: Radius.circular(Sizes.s40),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Sizes.s36,
              height: Sizes.s3,
              decoration: BoxDecoration(
                color: ConstColors.greyC4C4,
                borderRadius: BorderRadius.circular(Sizes.s12),
              ),
            ),
            SizedBox(height: Sizes.s16),
            PoppinsText(
              text: 'Logout',
              fontSize: Sizes.s24,
              fontWeight: FontWeight.w600,
              color: ConstColors.red,
            ),
            SizedBox(height: Sizes.s20),
            Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
            SizedBox(height: Sizes.s20),
            PoppinsText(
              text: 'Are you sure you want to log out?',
              fontSize: Sizes.s16,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: Sizes.s20),
            Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
            SizedBox(height: Sizes.s26),
            Row(
              spacing: Sizes.s10,
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: 'Cancel',
                    textColor: Colors.black,
                    buttonColor: ConstColors.secondary,

                    onTap: () {
                      // logout logic here
                      Navigator.pop(context);
                    },
                  ),
                ),

                Expanded(
                  child: CustomButton(
                    buttonText: 'Logout',

                    //   buttonWidth: 184,
                    onTap: () {
                      // logout Logic here
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to show the bottom sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.s40),
          topRight: Radius.circular(Sizes.s40),
        ),
      ),
      builder: (context) => const LogoutBottomSheet(),
    );
  }
}
