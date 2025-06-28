import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/analysis_listtile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/creator_List_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/day_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/assets.dart';

class CreatorModeTab extends StatefulWidget {
  const CreatorModeTab({super.key});

  @override
  State<CreatorModeTab> createState() => _CreatorModeTabState();
}

class _CreatorModeTabState extends State<CreatorModeTab> {
  int selectTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Consumer<UserViewModel>(
        builder: (context, vm, _) {
          final creatorVm = vm.userModel;

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: Sizes.s150,
                color: ConstColors.black,

                child: Column(
                  spacing: Sizes.s10,

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PoppinsText(
                      text: "\$${vm.getBalance(creatorVm).toStringAsFixed(2)}",
                      fontSize: Sizes.s30,
                      color: ConstColors.white,
                      fontWeight: TextWeight.semiBold,
                    ),
                    PoppinsText(
                      text: "Balance Available",
                      fontSize: Sizes.s10,
                      color: ConstColors.white,
                      fontWeight: TextWeight.regular,
                    ),
                    DaysChip(
                      daylist: ["1D", "1W", "1M", "3M", "1Y"],
                      selectTab: selectTab,
                      onTap: (index) {
                        setState(() {
                          selectTab = index;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AnalysisLisTile(
                          heading1: "Total sales",
                          heading2: creatorVm?.sold.length.toString() ?? "0",
                          iconImage: Assets.chartBlack,
                        ),
                        AnalysisLisTile(
                          heading1: "Cancelled",
                          heading2: vm.cancelCount(creatorVm).toString(),
                          iconImage: Assets.closeSquare,
                          iconColor: ColorFilter.mode(
                            ConstColors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        AnalysisLisTile(
                          heading1: "Ratings",
                          heading2: "${creatorVm?.rating ?? 0.0}",
                          iconImage: Assets.star1,
                        ),

                        AnalysisLisTile(
                          heading1: "Withdrawed",
                          heading2: "\$${creatorVm?.withdraw ?? 0.0}",
                          iconImage: Assets.upload1,
                        ),
                      ],
                    ),

                    SizedBox(height: Sizes.s20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PoppinsText(
                          text: "Your Programs",
                          fontSize: Sizes.s20,
                          fontWeight: TextWeight.semiBold,
                          color: ConstColors.black,
                        ),
                        PoppinsText(
                          text: "See All",
                          fontSize: Sizes.s14,
                          fontWeight: TextWeight.semiBold,
                          color: ConstColors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<List<ProgramModel>>(
                  stream: vm.getProgamOfCreatoe(creatorVm?.userId ?? ""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    final programs = snapshot.data ?? [];
                    if (programs.isEmpty) {
                      return PoppinsText(
                        text: "No Programs",
                        fontSize: Sizes.s16,
                        color: ConstColors.greyA1A1,
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return CreatorListItems( programModel: programs[index], );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(height: Sizes.s20);
                      },
                      itemCount: programs.length,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
