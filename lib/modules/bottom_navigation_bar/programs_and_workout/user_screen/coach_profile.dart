import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CoachProfile extends StatefulWidget {
  const CoachProfile({super.key});

  @override
  State<CoachProfile> createState() => _CoachProfileState();
}

class _CoachProfileState extends State<CoachProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(actionIcon: Icons.more_horiz_outlined),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: context.screenheight * 0.3,
            decoration: BoxDecoration(
              // color: ConstColors.amber,
              image: DecorationImage(image: AssetImage(Assets.profilebg)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage(Assets.workout),
                ),
                SizedBox(height: Sizes.s10),
                PoppinsText(
                  text: "Coach name",
                  fontSize: Sizes.s20,
                  fontWeight: TextWeight.semiBold,
                ),
                Row(
                  spacing: Sizes.s10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: ConstColors.orange, size: 20),
                    PoppinsText(text: "4.6 |", fontSize: Sizes.s10),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ConstColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 18),
                          PoppinsText(
                            text: "Premium Creator",
                            fontSize: Sizes.s10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
