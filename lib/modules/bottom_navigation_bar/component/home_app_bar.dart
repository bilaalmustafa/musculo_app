import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/notification_switch.dart';
import 'package:musculo_app/core/config/routes.dart';
import '../../../core/constants/assets.dart';
import '../../auth/view_model/view_mode_provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => Size(double.infinity, Sizes.s100);

  @override
  Widget build(BuildContext context) {
    final authService = instance<AuthService>();
    final viewModeVm = context.watch<ViewModeProvider>();
    final isCreatorView = viewModeVm.isCreatorView;

    return StreamBuilder<UserModel?>(
      stream: context.read<UserViewModel>().getUserByIdstream(
        authService.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CustomShimmer(height: 10)));
        }

        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('An error occurred')));
        }

        final user = snapshot.data;
        final isCreator = (user?.role ?? 'user') == 'creator';

        return AppBar(
          toolbarHeight: 100,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor:
              !isCreatorView ? ConstColors.white : ConstColors.black,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsText(
                text: "Welcome Back 👋",
                fontSize: Sizes.s14,
                color: ConstColors.greyB1B1,
                fontWeight: TextWeight.semiBold,
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                CustomShimmer(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.3,
                )
              else
                PoppinsText(
                  text: user?.name ?? "User name",
                  fontSize: Sizes.s20,
                  color: isCreatorView ? ConstColors.white : ConstColors.black,
                  fontWeight: TextWeight.semiBold,
                ),
            ],
          ),
          actions: [
            PoppinsText(
              text: isCreatorView ? "Creator" : "User",
              fontSize: Sizes.s11,
              color: isCreatorView ? ConstColors.white : ConstColors.black,
              fontWeight: TextWeight.medium,
            ),
            NotificationSwitch(
              useCupertino: true,
              value: isCreatorView,
              onChanged: (value) async {
                // Do NOT update Firestore — only sync PageView
                // onSwitchChanged(isCreator);
                if (isCreator) {
                  await viewModeVm.toggleView(value);
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
            if (isCreatorView)
              PopupMenuButton<String>(
                color: ConstColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                icon: SharePicture(
                  imagePath: Assets.plusIcon,
                  width: Sizes.s24,
                  height: Sizes.s24,
                  colorFilter: ColorFilter.mode(
                    ConstColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onSelected: (value) {
                  if (value == "workout") {
                    Navigator.pushNamed(context, Routes.addworkoutpageview);
                  } else {
                    Navigator.pushNamed(context, Routes.addprogrampageview);
                  }
                },
                itemBuilder:
                    (BuildContext context) => [
                      PopupMenuItem(
                        value: 'workout',
                        child: Row(
                          spacing: 10,
                          children: [
                            SharePicture(imagePath: Assets.runnerIcon),
                            PoppinsText(
                              text: "Add Workouts",
                              fontSize: Sizes.s12,
                              fontWeight: TextWeight.medium,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'program',
                        child: Row(
                          spacing: 10,
                          children: [
                            SharePicture(imagePath: Assets.calendarIcon),
                            PoppinsText(
                              text: "Add Program",
                              fontSize: Sizes.s12,
                              fontWeight: TextWeight.medium,
                            ),
                          ],
                        ),
                      ),
                    ],
              ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.settingScreen);
              },
              icon: SharePicture(
                imagePath: Assets.settingIcon,
                width: Sizes.s24,
                height: Sizes.s24,
                colorFilter: ColorFilter.mode(
                  isCreatorView ? ConstColors.white : ConstColors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
