import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/carasoul_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/item_container.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/show_bottom_sheet.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/video_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/component/home_app_bar.dart';
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
                          return ShowBottomSheet();
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
