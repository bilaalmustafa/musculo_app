import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/vedioplayer.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/video_frame_screen.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';

import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class WarmUp extends StatefulWidget {
  const WarmUp({super.key});

  @override
  State<WarmUp> createState() => _WarmUpState();
}

class _WarmUpState extends State<WarmUp> {
  // late VideoPlayerController _controller;
  final TextEditingController _searchController = TextEditingController();
  late AddWorkoutVeiwModel _addWorkoutVeiwModel;
  @override
  void initState() {
    super.initState();
    _addWorkoutVeiwModel = context.read<AddWorkoutVeiwModel>();
    if (_addWorkoutVeiwModel.storagevideos.isEmpty) {
      _addWorkoutVeiwModel.loadVideos();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    // _controller.dispose();
    _addWorkoutVeiwModel.searchQuery = ''; // Clear search when leaving screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Consumer<AddWorkoutVeiwModel>(
        builder: (context, vm, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsText(
                      text: vm.selectedSections[vm.currentSectionIndex],
                      fontSize: Sizes.s24,
                      fontWeight: TextWeight.semiBold,
                    ),
                    CustomTextField(
                      title: "search exercise",
                      controller: _searchController,
                      // sufIcon: Assets.filterIcon,
                      preIcon: Assets.searchIcon,
                      // onTap: () {
                      //   Navigator.pushNamed(context, Routes.filterscreen);
                      // },
                      onChanged: (value) {
                        vm.searchQuery = value;
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(Sizes.s16),
                  child:
                      vm.isvedioLoading && vm.storagevideos.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : vm.errorMessage != null
                          ? Center(child: Text(vm.errorMessage!))
                          : vm.storagevideos.isEmpty
                          ? const Center(child: Text("No videos found"))
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PoppinsText(
                                    text: "Select exercises",
                                    fontSize: Sizes.s16,
                                    fontWeight: TextWeight.semiBold,
                                  ),
                                  PoppinsText(
                                    text: "${vm.filteredVideos.length} found",
                                    fontSize: Sizes.s12,
                                    fontWeight: TextWeight.bold,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    // final controller = _controllers[index];
                                    final video = vm.filteredVideos[index];
                                    return InkWell(
                                      onTap: () {
                                        vm.videoSelected(video);
                                      },
                                      child: ReelsItem(
                                        videodata: video,
                                        onTap: ()  {
                                        
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => Vedioplayercreen(
                                                    videoUrl: video.url,
                                                  ),
                                            ),
                                          );
                                        },
                                        selected: vm.selectedList.contains(
                                          video,
                                        ),

                                        // controller: controller,
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (context, index) =>
                                          const SizedBox(height: 10),
                                  itemCount: vm.filteredVideos.length,
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
