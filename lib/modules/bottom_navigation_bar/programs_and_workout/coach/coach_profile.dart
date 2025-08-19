import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/components/tab_buttons.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/profile_view_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/coach/coach_profile_text_tab.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/tab/program_tab.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/work_out_tab.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/user_service.dart';
import '../../../../model/user_model.dart';
import '../../home_and_training_screens/component/show_rating_bottom_sheet.dart';

class CoachProfile extends StatefulWidget {
  final String userId;
  const CoachProfile({super.key, required this.userId});

  @override
  State<CoachProfile> createState() => _CoachProfileState();
}

class _CoachProfileState extends State<CoachProfile> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: UserService().userByIdstream(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(body: Center(child: Text("Creator not found")));
        }

        final data = snapshot.data!;
        return Scaffold(
          backgroundColor: ConstColors.white,
          appBar: SharedAppBar(
            trailing: PopupMenuButton<String>(
              color: ConstColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (value) {
                if (value == "rate") {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    barrierColor: ConstColors.black.withValues(alpha: .8),
                    constraints: BoxConstraints(
                      maxHeight: context.screenheight * 0.7,
                    ),
                    backgroundColor: ConstColors.white,
                    context: context,
                    builder: (context) => ShowRatingBottomSheet(creator: data),
                  );
                }

                if (value == "feedback") {
                  Navigator.pushNamed(
                    context,
                    Routes.feedbScreen,
                    arguments: {
                      'feedbackType': 'Creator',
                      'contentId': data.userId ?? "",
                      'rating': data.rating ?? 0.0,
                      'contentName': data.name ?? "",
                    },
                  );
                }
                if (value == "report") {
                  Navigator.pushNamed(
                    context,
                    Routes.reportScreen,
                    arguments: {
                      'reportType': 'Report Creator',
                      'contentId': data.userId ?? "",
                      'rating': data.rating ?? 0.0,
                      'contentName': data.name ?? "",
                    },
                  );
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'rate',
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            color: ConstColors.black,
                          ),
                          const SizedBox(width: 8),
                          const Text('Rate Creator'),
                        ],
                      ),
                    ),
                    // PopupMenuItem(
                    //   value: 'edit',
                    //   child: Row(
                    //     children: [
                    //       SharePicture(imagePath: Assets.editIcon),
                    //       const SizedBox(width: 8),
                    //       Text('Edit Rating'),
                    //     ],
                    //   ),
                    // ),
                    PopupMenuItem(
                      value: 'feedback',
                      child: Row(
                        children: [
                          SharePicture(
                            imagePath: Assets.feedbackIcon,
                            colorFilter: ColorFilter.mode(
                              ConstColors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('Feedback'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'report',
                      child: Row(
                        children: [
                          SharePicture(
                            imagePath: Assets.reportIcon,
                            colorFilter: ColorFilter.mode(
                              ConstColors.red,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Report',
                            style: TextStyle(color: ConstColors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
              icon: SharePicture(
                imagePath: Assets.moreHrizontal,
                colorFilter: ColorFilter.mode(
                  ConstColors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: Sizes.s200,
                decoration: BoxDecoration(
                  //color: ConstColors.amber,
                  image: DecorationImage(
                    image: AssetImage(Assets.profilebgpng),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage:
                          data.profileImageUrl != null
                              ? NetworkImage(data.profileImageUrl!)
                              : AssetImage(Assets.coachProfile),
                    ),
                    SizedBox(height: Sizes.s10),
                    PoppinsText(
                      text: data.name ?? "Unknown",
                      fontSize: Sizes.s20,
                      fontWeight: TextWeight.semiBold,
                    ),
                    SizedBox(height: Sizes.s3),

                    Row(
                      spacing: Sizes.s10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: ConstColors.orange, size: 20),
                        PoppinsText(
                          text: "${data.rating ?? 0.0}",
                          fontSize: Sizes.s10,
                        ),
                        Container(height: 15, width: 1.5, color: Colors.black),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: ConstColors.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            spacing: Sizes.s2,
                            children: [
                              data.subPlane != "Free"
                                  ? SharePicture(imagePath: Assets.daimond)
                                  : Container(),
                              PoppinsText(
                                text: "${data.subPlane ?? ""} Creator",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Consumer<ProfileProvider>(
                  builder: (context, tabVm, _) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_pageController.hasClients &&
                          _pageController.page?.round() != tabVm.selectTab) {
                        _pageController.jumpToPage(tabVm.selectTab);
                      }
                    });
                    return TabButtons(
                      selecttab: tabVm.selectTab,
                      tabNames: ["Description", "Workouts", "Programs"],
                      onChange: (index) {
                        tabVm.setTab(index);
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    CoachProfileTextScreen(creator: data),
                    WorkOutTabDisScreen(userId: data.userId),
                    // ProgramWorkOutsTab(),
                    ProgramTabDisScreen(userId: data.userId),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
