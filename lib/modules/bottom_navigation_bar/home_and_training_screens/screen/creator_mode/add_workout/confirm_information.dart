import 'package:flutter/material.dart';

import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';
import 'package:provider/provider.dart';

class ConfirmInformation extends StatefulWidget {
  const ConfirmInformation({super.key});

  @override
  State<ConfirmInformation> createState() => _WarmUpState();
}

class _WarmUpState extends State<ConfirmInformation> {
  late AddWorkoutVeiwModel vm;
  late List<Map<String, dynamic>> listinfo;
  @override
  void initState() {
    vm = context.read<AddWorkoutVeiwModel>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    vm = context.read<AddWorkoutVeiwModel>();
    int totalSeconds = vm.getTotalIntervalTimeInSeconds();
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    listinfo = [
      {"Workoutname": vm.workoutNameController.text},
      {"Type": vm.typeofworkout},
      {"added to": vm.selectedSections.join("-")},
      {"Difficulty": "${vm.difficulty.round()}/10"},
      {"Level": vm.levelofworkout},
      {"Gender": vm.gender},
      {
        "Total time":
            "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
      },
      {"Price": "\$${vm.priceController.text}"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: SingleChildScrollView(
        child: Column(
          spacing: Sizes.s20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  PoppinsText(
                    text: "Confirm the information below",
                    fontSize: Sizes.s24,
                    fontWeight: TextWeight.semiBold,
                  ),
                  PoppinsText(
                    text: "Training details",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ConstColors.white,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(listinfo.length, (index) {
                        final enty = listinfo[index].entries.first;
                        return ListTile(
                          leading: PoppinsText(
                            text: enty.key,
                            fontSize: Sizes.s12,
                            color: ConstColors.greyA1A1,
                          ),
                          trailing: PoppinsText(
                            text: enty.value.toString(),
                            fontSize: Sizes.s12,
                            color: ConstColors.black,
                          ),
                        );
                      }),
                    ),
                  ),

                  Consumer<AddWorkoutVeiwModel>(
                    builder: (context, vm, _) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: vm.selectedVideos.length,
                        itemBuilder: (context, ind) {
                          final sectionTitle = vm.selectedVideos.keys.elementAt(
                            ind,
                          );
                          final videos = vm.selectedVideos[sectionTitle]!;
                          return Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PoppinsText(
                                text: sectionTitle,
                                fontSize: Sizes.s18,
                                fontWeight: TextWeight.semiBold,
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final video = videos.elementAt(index);
                                  final int minutes = video.restTime ~/ 60;
                                  final int seconds = video.restTime % 60;
                                  return Column(
                                    spacing: 5,
                                    children: [
                                      ReelsItem(
                                        videodata: video,

                                        screenintervel: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          PoppinsText(
                                            text: "Rest time",
                                            fontSize: Sizes.s14,
                                            fontWeight: TextWeight.semiBold,
                                          ),

                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ConstColors.white,
                                              border: Border.all(
                                                color: ConstColors.secondary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: PoppinsText(
                                              text:
                                                  "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                                              fontSize: 10,
                                              color: ConstColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (contxt, index) {
                                  return SizedBox(height: 10);
                                },
                                itemCount: videos.length,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
