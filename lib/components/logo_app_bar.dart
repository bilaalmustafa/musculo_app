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

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LogoAppBar({
    super.key,
    this.selectedindex,
    required this.onSelected,
    required this.title,
    this.huintText,
    this.buttonTabList,
  });
  final int? selectedindex;
  final ValueChanged<int> onSelected;

  final String title;
  final String? huintText;
  final List<String>? buttonTabList;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 100),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              trailing: Icon(Icons.more_horiz_outlined),
            ),
          ),
          huintText != null
              ? CustomTextField(
                prefexicon: Icons.search,
                title: huintText!,
                suffexicon: Icons.filter_1_outlined,
                onTap: () {
                  Navigator.pushNamed(context, Routes.filterscreen);
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
