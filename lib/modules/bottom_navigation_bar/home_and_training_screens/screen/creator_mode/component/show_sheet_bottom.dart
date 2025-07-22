import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/video_frame_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/sizes.dart';

class ShowSheetBottom extends StatefulWidget {
  const ShowSheetBottom({super.key, required this.selectedVideo});
  final VideoModel selectedVideo;

  @override
  State<ShowSheetBottom> createState() => _ShowSheetBottomState();
}

class _ShowSheetBottomState extends State<ShowSheetBottom> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: FractionallySizedBox(
        heightFactor: 0.7,
        child: Consumer<AddWorkoutVeiwModel>(
          builder: (context, vm, _) {
            return Column(
              spacing: 10,
              children: [
                Container(
                  height: 3,
                  width: 40,
                  margin: const EdgeInsets.only(top: Sizes.s16),
                  decoration: BoxDecoration(
                    color: ConstColors.greyC8C8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                PoppinsText(
                  text: "Add Versions",
                  fontSize: Sizes.s18,
                  fontWeight: TextWeight.semiBold,
                ),

                Divider(
                  color: ConstColors.dividerColor,
                  indent: 16,
                  endIndent: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.s16),
                  child: CustomTextField(
                    controller: _searchController,
                    title: "search exercise",
                    preIcon: Assets.searchIcon,
                    sufIcon:
                        _searchController.text.isNotEmpty
                            ? Assets.crossIcon
                            : null,
                    onTap: () {
                      setState(() {
                        _searchController.clear();
                        vm.searchQuery = '';
                      });
                    },
                    onChanged: (value) {
                      vm.searchQuery = value;
                    },
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s16),
                    color: ConstColors.secondary,
                    child:
                        vm.filteredVideos.isEmpty
                            ? const Center(child: Text("No videos found"))
                            : ListView.separated(
                              itemBuilder: (context, index) {
                                final video = vm.filteredVideos[index];

                                return InkWell(
                                  onTap: () {
                                    vm.addversionvideo(video);
                                  },
                                  child: ReelsItem(
                                    videodata: video,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => VideoFrameScreen(
                                                  videourl: video.url,
                                                ),
                                          ),
                                        ),

                                    selected: vm.addVersionList.contains(video),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10);
                              },
                              itemCount: vm.filteredVideos.length,
                            ),
                  ),
                ),

                Container(
                  color: ConstColors.white,

                  margin: EdgeInsets.only(
                    bottom: Sizes.s16,
                    left: Sizes.s16,
                    right: Sizes.s16,
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CustomButton(
                          buttonText: "Back",
                          buttonColor: ConstColors.secondary,
                          textColor: ConstColors.black,
                          onTap: () {
                            _searchController.clear();
                            vm.searchQuery = '';
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            vm.addVersionToVideo(widget.selectedVideo);
                            _searchController.clear();
                            vm.searchQuery = '';
                            Navigator.pop(context);
                          },
                          buttonText: "Add",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
