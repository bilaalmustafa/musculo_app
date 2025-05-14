import 'package:flutter/material.dart';

import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
    this.selectedindex,
    required this.onSelected,
    this.appbarTitle,
  });
  final int? selectedindex;
  final ValueChanged<int>? onSelected;
  final String? appbarTitle;
  @override
  Widget build(BuildContext context) {
    List<String> tab = ["Workouts", "programs"];

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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: PoppinsText(
                text: appbarTitle ?? '',
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ConstColors.secondary,
            ),
            child: Row(
              children: List.generate(tab.length, (index) {
                final isSelected = index == selectedindex;
                return Expanded(
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            isSelected
                                ? ConstColors.black
                                : ConstColors.secondary,
                      ),

                      child: PoppinsText(
                        text: tab[index],
                        fontSize: Sizes.s13,
                        fontWeight: TextWeight.regular,
                        color:
                            isSelected ? ConstColors.white : ConstColors.black,
                      ),
                    ),
                    onTap: () => onSelected!(index),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Sizes.s300);
}
