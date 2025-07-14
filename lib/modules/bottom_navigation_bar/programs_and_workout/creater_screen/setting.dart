import 'package:flutter/material.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/account_storage.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/customlisttile.dart';

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

                switchBottomSheet(
                  // ignore: use_build_context_synchronously
                  safeContext,
                  accounts,
                  currentEmail,
                  authprovider,
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

  // Helper method to create login icon based on provider
  Widget _buildLoginIcon(
    String email,
    String provider, {
    String? profileImageUrl,
    String? userName,
  }) {
    if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: Colors.blueGrey[100],
        backgroundImage: NetworkImage(profileImageUrl),
        radius: 20,
        child: null,
      );
    }

    switch (provider.toLowerCase()) {
      case 'google':
        return CircleAvatar(
          backgroundColor: Colors.blueGrey[100],
          child: SharePicture(imagePath: Assets.google),
        );
      case 'facebook':
        return CircleAvatar(
          backgroundColor: Colors.blueGrey[100],
          child: SharePicture(imagePath: Assets.facebook),
        );
      case 'email':
      default:
        return CircleAvatar(
          backgroundColor: Colors.blueGrey[100],
          child: Text(
            email.isNotEmpty ? email[0].toUpperCase() : 'U',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        );
    }
  }

  Future<dynamic> switchBottomSheet(
    BuildContext safeContext,
    List<String> accounts,
    String? currentEmail,
    AuthViewModel authprovider,
  ) {
    return showModalBottomSheet(
      context: safeContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final email = accounts[index];
                    final isSelected = email == currentEmail;

                    return FutureBuilder<Map<String, String>?>(
                      future: AccountStorage.getCredentials(email),
                      builder: (context, snapshot) {
                        final credentials = snapshot.data;
                        final provider = credentials?['provider'] ?? 'email';
                        final profileImageUrl = credentials?['profileImageUrl'];
                        final userName = credentials?['userName'];

                        return ListTile(
                          leading: _buildLoginIcon(
                            email,
                            provider,
                            profileImageUrl: profileImageUrl,
                            userName: userName,
                          ),
                          title: Text(
                            email,
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                            'Login via: ${provider.toUpperCase()}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing:
                              isSelected
                                  ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                  : GestureDetector(
                                    onTap: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              backgroundColor:
                                                  ConstColors.white,
                                              title: const Text(
                                                'Delete Account',
                                              ),
                                              content: const Text(
                                                'Are you sure you want to delete this account?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                        false,
                                                      ),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                        true,
                                                      ),
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );

                                      if (confirm == true) {
                                        // close the bottom sheet
                                        Navigator.pop(context);
                                        await authprovider.removeAccount(email);
                                      }
                                    },
                                    child: SharePicture(
                                      imagePath: Assets.deleteIcon,
                                      colorFilter: const ColorFilter.mode(
                                        ConstColors.red,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                          onTap: () async {
                            Navigator.of(context, rootNavigator: true).pop();

                            if (!isSelected) {
                              await authprovider.switchAccount(email);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
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
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
