import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/share_to_social.dart';

class ShowShareBottomSheet extends StatelessWidget {
  const ShowShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            spacing: Sizes.s20,
                            children: [
                              Container(
                                height: 3,
                                width: 30,
                                color: ConstColors.secondary,
                              ),

                              PoppinsText(
                                text: "Share to",
                                fontSize: Sizes.s20,
                                fontWeight: TextWeight.semiBold,
                              ),
                              Divider(color: ConstColors.secondary, height: 2),
                              ShareToSocial(),
                              Divider(color: ConstColors.secondary, height: 2),
                              CustomButton(buttonText: "Back home"),
                            ],
                          ),
                        );
  }
}