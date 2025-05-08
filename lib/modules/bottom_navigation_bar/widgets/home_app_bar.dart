import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 15),
      title: PoppinsText(
        text: "Welcome Back  👋",
        fontSize: Sizes.s14,
        color: ConstColors.greyB1B1,
        fontWeight: TextWeight.semiBold,
      ),
      subtitle: PoppinsText(
        text: "Full user name",
        fontSize: Sizes.s20,
        color: ConstColors.black,
        fontWeight: TextWeight.semiBold,
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.end,

        children: [
          PoppinsText(
            text: "user",
            fontSize: Sizes.s11,
            fontWeight: TextWeight.medium,
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              activeColor: ConstColors.green10,
              value: true,
              onChanged: (vlue) {},
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
