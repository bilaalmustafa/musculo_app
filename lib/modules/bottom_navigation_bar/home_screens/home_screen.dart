import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_screens/widgets/carasoul_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_screens/widgets/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_screens/widgets/item_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_screens/widgets/video_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/widgets/home_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ).copyWith(top: context.screenheight * 0.05),
        child: SingleChildScrollView(
          child: Column(
            spacing: Sizes.s20,
            children: [
              HomeAppBar(),
              CustomTextField(
                title: "Search program",
                prefexicon: Icons.search,
                suffexicon: Icons.filter_list_outlined,
              ),
              CarasoulContainer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PoppinsText(
                    text: "Top Programs",
                    fontSize: Sizes.s18,
                    fontWeight: TextWeight.semiBold,
                    color: ConstColors.black,
                  ),
                  PoppinsText(
                    text: "See All",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                    color: ConstColors.black,
                  ),
                ],
              ),
              ItemContainer(),
              // Container(
              //   color: ConstColors.red,
              //   width: double.infinity,
              //   height: 230,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 5,
              //     itemBuilder: (context, index) {
              //       return
              //     },
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PoppinsText(
                    text: "Your Programs",
                    fontSize: Sizes.s18,
                    fontWeight: TextWeight.semiBold,
                    color: ConstColors.black,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: ConstColors.white,
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        builder: (_) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Sizes.s20,
                              vertical: Sizes.s8,
                            ),
                            height: 600,
                            decoration: BoxDecoration(
                              color: ConstColors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32),
                              ),
                            ),

                            child: Column(
                              spacing: Sizes.s20,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 4,
                                  width: 50,
                                  color: ConstColors.secondary,
                                ),
                                PoppinsText(
                                  text: "Choose Program",
                                  fontSize: Sizes.s20,
                                  fontWeight: TextWeight.semiBold,
                                  color: ConstColors.black,
                                ),
                                Divider(
                                  color: ConstColors.secondary,
                                  thickness: 2,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder:
                                        (context, index) => VideoItem(),
                                    separatorBuilder:
                                        (context, index) =>
                                            SizedBox(height: 20),
                                  ),
                                ),

                                Divider(
                                  color: ConstColors.secondary,
                                  thickness: 2,
                                ),
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
                                      child: CustomButton(buttonText: "Start"),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Sizes.s5),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: PoppinsText(
                      text: "See All",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.medium,
                      color: ConstColors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: ListView.separated(
                  itemCount: 3,
                  itemBuilder:
                      (context, index) => VideoItem(image: Assets.playbutton),
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
