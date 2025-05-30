import 'package:flutter/material.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/home_screen.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/customlisttile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/switchbottomsheet.dart';
import 'package:provider/provider.dart';

import '../../../auth/view_model/auth_view_model.dart';
import '../component/bottomsheet.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authprovider = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.s0,
          vertical: Sizes.s10,
        ),

        child: Column(
          children: [
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.addUser,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Add Account",
              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () async {
                // Add Account Related code here
                await authprovider.logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.signInscreen,
                    (route) => false,
                  );
                }
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.switchUser,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Switch Account",

              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () async {
                final safeContext = context;
                final accounts = await authprovider.getSavedAccounts();
                final currentEmail = await authprovider.getCurrentUserEmail();

                showModalBottomSheet(
                  context: safeContext,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      height: 400,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const Text(
                            'Switch Account',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            height: Sizes.s1,
                            color: ConstColors.greyE5E5,
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: accounts.length,
                              itemBuilder: (context, index) {
                                final email = accounts[index];
                                final isSelected = email == currentEmail;

                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blueGrey[100],
                                    child: Text(
                                      email[0].toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    email,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  trailing:
                                      isSelected
                                          ? const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          )
                                          : null,
                                  onTap: () async {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pop();

                                    if (!isSelected) {
                                      await authprovider.switchAccount(email);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                            Navigator.pushNamedAndRemoveUntil(
                                              safeContext,
                                              Routes.bottomnavigationbarscreen,
                                              (route) => false,
                                            );
                                          });
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.notification,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Notifications",
              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () {
                Navigator.pushNamed(context, Routes.notificationScreen);
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.condition,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Conditions Of Use",

              trailing: Icon(Icons.arrow_forward_ios, size: Sizes.s16),
              onTap: () {
                // condition of use realated code here
              },
            ),
            CustomListTile(
              leading: SharePicture(
                imagePath: Assets.logout,
                width: Sizes.s24,
                height: Sizes.s24,
              ),
              title: "Logout",
              titleColor: ConstColors.red,

              onTap: () {
                LogoutBottomSheet.show(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
