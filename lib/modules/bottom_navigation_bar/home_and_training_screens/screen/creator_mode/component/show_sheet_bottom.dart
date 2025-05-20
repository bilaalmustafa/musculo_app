import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';

class ShowSheetBottom extends StatelessWidget {
  const ShowSheetBottom({super.key, required this.ListController});
   final  List ListController;
  @override
  Widget build(BuildContext context) {
    return  Column(
                  spacing: 10,
                  children: [
                    Container(
                      height: 4,
                      width: 20,
                      color: ConstColors.secondary,
                    ),
                    PoppinsText(
                      text: "Add Version",
                      fontSize: 18,
                      fontWeight: TextWeight.semiBold,
                    ),

                    Divider(color: ConstColors.dividerColor),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        title: "search exercise",
                        prefexicon: Icons.search,
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        color: ConstColors.secondary,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final controller = ListController[index];
                            return ReelsItem(controller: controller);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: 3,
                        ),
                      ),
                    ),

                    Container(
                      color: ConstColors.white,
                      
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonText: "Back",
                              buttonColor: ConstColors.secondary,
                              textColor: ConstColors.black,
                            ),
                          ),
                          Expanded(child: CustomButton(buttonText: "Add")),
                        ],
                      ),
                    ),
                  ],
                );
  }
}