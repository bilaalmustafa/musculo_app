import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/tab_buttons.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:provider/provider.dart';

import '../modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_filter_provider.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LogoAppBar({
    super.key,
    this.selectedindex,
    required this.onSelected,
    required this.title,
    this.huintText,
    this.buttonTabList,
    this.controller,
  });
  final int? selectedindex;
  final ValueChanged<int> onSelected;

  final String title;
  final String? huintText;
  final List<String>? buttonTabList;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final filter = context.watch<DiscoverFilter>();
    return Container(
      constraints: BoxConstraints(minHeight: Sizes.s100),
      padding: EdgeInsets.symmetric(vertical: Sizes.s10, horizontal: Sizes.s20),
      color: ConstColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: Sizes.s10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Sizes.s20),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SharePicture(imagePath: Assets.monogram, height: 30),
              title: PoppinsText(
                text: title,
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              ),
              // trailing: SharePicture(imagePath: Assets.moreHrizontal),
            ),
          ),
          huintText != null
              ? CustomTextField(
                preIcon: Assets.searchIcon,
                title: huintText!,
                controller: controller,

                sufIcon:
                    filter.isFilterApplied
                        ? Assets.crossIcon
                        : Assets.filterIcon,
                onTap: () {
                  if (filter.isFilterApplied) {
                    filter.clear();
                  } else {
                    Navigator.pushNamed(context, Routes.filterscreen);
                  }
                },
              )
              : Container(),
          buttonTabList != null
              ? TabButtons(
                tabNames: buttonTabList!,
                selecttab: selectedindex!,
                onChange: (index) {
                  onSelected(index);
                },
              )
              : Container(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Sizes.s300);
}
