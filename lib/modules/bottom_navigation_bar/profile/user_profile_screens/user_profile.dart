import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/logo_title_appbar.dart';

import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/profile_image_services.dart';
import 'package:musculo_app/core/utils/profilehelper.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/profile_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/notification_switch.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../../auth/view_model/view_mode_provider.dart';
import '../../home_and_training_screens/component/congrate_container.dart';
import '../../programs_and_workout/component/customlisttile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final ProfileImageService _profileImageService = ProfileImageService();

  @override
  Widget build(BuildContext context) {
    final userVm = context.watch<UserViewModel>();
    final viewModeVm = context.watch<ViewModeProvider>();
    final data = userVm.userModel;
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final isCreator = data?.role == 'creator';
    final isCreatorView = viewModeVm.isCreatorView;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.white,
        appBar: LogoTitleAppBar(title: 'Profile'),

        body: Padding(
          padding: EdgeInsets.all(Sizes.s16),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: Sizes.s120,
                    width: Sizes.s300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SharePicture(imagePath: Assets.groupCircle),
                        StreamBuilder(
                          stream: _profileImageService.userProfileImageStream(
                            uid,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircleAvatar(
                                maxRadius: Sizes.s55,
                                backgroundColor: ConstColors.greyE0E0,
                                child: CustomShimmer(height: 0),
                              );
                            }
                            final imageUrl = snapshot.data;
                            //MARK:
                            return CircleAvatar(
                              maxRadius: Sizes.s55,
                              backgroundColor:
                                  imageUrl == null ? ConstColors.black : null,
                              backgroundImage:
                                  imageUrl != null
                                      ? NetworkImage(imageUrl)
                                      : null,
                              child:
                                  imageUrl == null
                                      ? PoppinsText(
                                        text: data!.name![0].toUpperCase(),
                                        fontSize: 40,
                                        fontWeight: TextWeight.semiBold,
                                        color: ConstColors.white,
                                      )
                                      : null,
                            );
                          },
                        ),

                        Transform.translate(
                          offset: Offset(Sizes.s40, Sizes.s40),
                          child: InkWell(
                            onTap: () {
                              ProfileHelper.showImagePickerBottomSheet(context);
                            },

                            child: SharePicture(imagePath: Assets.eidtSquare),
                          ),
                        ),
                      ],
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
                      text: isCreatorView ? "Creator" : "User",
                      fontSize: Sizes.s14,
                      fontWeight: TextWeight.semiBold,
                    ),

                    NotificationSwitch(
                      value: isCreatorView,
                      useCupertino: true,
                      onChanged: (value) async {
                        if (isCreator) {
                          viewModeVm.toggleView(value);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'You must become a creator to switch modes.',
                              ),
                            ),
                          );
                        }
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
                      Navigator.pushNamed(
                        context,
                        Routes.becomeCreatorScreen,
                        arguments: {'fromUpgradePopup': false},
                      );
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
                              : data.finishedWorkouts.toString(),
                      text: isCreator ? "Programs Sold" : "Finished Workout",
                    ),
                    CongrateContainer(
                      imagePath:
                          isCreator ? Assets.walletIcon : Assets.timeCircle,
                      digit:
                          isCreator
                              ? ' ${userVm.getBalance(data).toStringAsFixed(1)}€'
                              : data.spentMinutes.toString(),
                      text: isCreator ? "Earnings" : "Minutes Spent",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
                SizedBox(height: 10),

                if (!isCreatorView) ...[
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
                      Navigator.pushNamed(
                        context,
                        Routes.motivationalListScreen,
                      );
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
                      Navigator.pushNamed(
                        context,
                        Routes.motivationalListScreen,
                      );
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
                      Navigator.pushNamed(
                        context,
                        Routes.creatorProfileScreen,
                        arguments: 1,
                      );
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
                        await context.read<ViewModeProvider>().setView(false);
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.bottomnavigationbarscreen,
                        );
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
