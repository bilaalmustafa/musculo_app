import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/logo_title_appbar.dart';

import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/utils/profilehelper.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/notification_switch.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../home_and_training_screens/component/congrate_container.dart';
import '../../programs_and_workout/component/customlisttile.dart';
import '../profile_view_model/profile_view_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isCreator = false;

  @override
  void initState() {
    Future.microtask(() {
      context.read<ProfileProvider>().loadProfileImage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userVm = context.watch<UserViewModel>();
    final data = userVm.userModel;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.white,
        appBar: LogoTitleAppBar(title: 'Profile'),

        body: Padding(
          padding: EdgeInsets.all(Sizes.s16),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: Sizes.s120,
                  width: Sizes.s300,
                  child: Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
                      final img = profileProvider.user?.profileImageUrl;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SharePicture(imagePath: Assets.groupCircle),
                          CircleAvatar(
                            maxRadius: Sizes.s55,
                            backgroundColor: ConstColors.greyE0E0,
                            backgroundImage:
                                img != null
                                    ? NetworkImage(img)
                                    : AssetImage(Assets.profileDImage)
                                        as ImageProvider,
                          ),

                          // loading indicator
                          if (profileProvider.isUploading)
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          Transform.translate(
                            offset: Offset(Sizes.s40, Sizes.s40),
                            child: InkWell(
                              onTap: () {
                                ProfileHelper.showImagePickerBottomSheet(
                                  context,
                                );
                              },

                              child: SharePicture(imagePath: Assets.eidtSquare),
                              // Container(
                              //   width: Sizes.s20,
                              //   height: Sizes.s20,
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.rectangle,
                              //     borderRadius: BorderRadius.circular(Sizes.s4),
                              //     color: ConstColors.black,
                              //   ),
                              //   child: Icon(
                              //     Icons.edit,
                              //     color: Colors.white,
                              //     size: Sizes.s20,
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: Sizes.s10),

              PoppinsText(
                text: data?.name ?? "User name",
                fontSize: Sizes.s24,
                fontWeight: FontWeight.w600,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PoppinsText(
                    text: isCreator ? "Creator" : "User",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.semiBold,
                  ),

                  NotificationSwitch(
                    value: isCreator,
                    useCupertino: true,
                    onChanged: (value) {
                      setState(() {
                        isCreator = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              CustomButton(
                buttonText:
                    data!.subPlane != null && data.subPlane == "free"
                        ? 'Become a Creator'
                        : "Cancel Creator Subcription",
                buttonColor:
                    data.subPlane == "free"
                        ? ConstColors.sky22B
                        : ConstColors.redFF4,
                onTap: () {
                  if (data.subPlane == "free") {
                    Navigator.pushNamed(context, Routes.becomeCreatorScreen);
                  } else {
                    showCancelSubscriptionDialog(context);
                  }
                },
              ),
              SizedBox(height: 5),

              Row(
                children: [
                  CongrateContainer(
                    imagePath:
                        isCreator ? Assets.runnerIcon : Assets.runnerIcon,
                    digit:
                        isCreator
                            ? userVm.soldProgram(data).toString()
                            : data?.finishedWorkouts.toString() ?? "0",
                    text: isCreator ? "Programs Sold" : "Finished Workout",
                  ),
                  CongrateContainer(
                    imagePath:
                        isCreator ? Assets.walletIcon : Assets.timeCircle,
                    digit:
                        isCreator
                            ? ' ${userVm.getBalance(data).toStringAsFixed(1)}£'
                            : data?.spentMinutes.toString() ?? "0",
                    text: isCreator ? "Earnings" : "Minutes Spent",
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
              SizedBox(height: 10),

              if (!isCreator) ...[
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.profileIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Account Information",
                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // Add Account information code here
                    Navigator.pushNamed(context, Routes.accountInfoScreen);
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.calendarIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "My Programs/Workouts",

                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.myProgramWorkout);
                    // program workout code here
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.heartIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Favorites",

                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // faverate code here
                    Navigator.pushNamed(context, Routes.favoriteScreen);
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.documentIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Motivational Text",
                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // motivvational text code here
                    Navigator.pushNamed(context, Routes.motivationalListScreen);
                  },
                ),
              ] else ...[
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.editIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Modify creator profile",
                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // Add modify creator profile  code here
                    Navigator.pushNamed(context, Routes.creatorProfileScreen);
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.documentIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Motivational Text",
                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // motivvational text code here
                    Navigator.pushNamed(context, Routes.motivationalListScreen);
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.calendarIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "My Programs/Workouts",

                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.creatorMyProgramWorkout,
                    );
                    // program workout code here
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.walletIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Earnings",
                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // earning text code here
                  },
                ),
                CustomListTile(
                  leading: SharePicture(
                    imagePath: Assets.heartIcon,
                    width: Sizes.s24,
                    height: Sizes.s24,
                  ),
                  title: "Favorites",

                  trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
                  onTap: () {
                    // faverate code here
                    Navigator.pushNamed(context, Routes.favoriteScreen);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void showCancelSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ConstColors.white,
          title: Text(
            'Attention',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('Do you want to cancel the creator subscription?'),
          actions: [
            Consumer<ProfileProvider>(
              builder: (context, vm, _) {
                return CustomButton(
                  loading: vm.isLoading,
                  buttonText: "Yes",
                  onTap: () async {
                    final uid = context.read<UserViewModel>().userModel!.userId;
                    if (uid != null) {
                      bool? success = await vm.cancelCreatorPlan(uid);
                      if (success != null && context.mounted) {
                        Navigator.of(context).pop();
                        // Navigator.pushNamed(
                        //   context,
                        //   Routes.bottomnavigationbarscreen,
                        // );
                        Fluttertoast.showToast(msg: "plane cancel successfull");
                      }
                    }
                  },
                );
              },
            ),
            SizedBox(height: 5),
            CustomButton(
              buttonText: "No",
              textColor: ConstColors.black,
              buttonColor: ConstColors.secondary,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
