import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class AddIndended extends StatefulWidget {
  const AddIndended({super.key});

  @override
  State<AddIndended> createState() => _AddIndendedState();
}

class _AddIndendedState extends State<AddIndended> {
  String valueoption = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: "This program is intended for",
              fontSize: Sizes.s24,
              fontWeight: TextWeight.semiBold,
            ),
            SizedBox(height: Sizes.s15),

            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Male",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Male",
              groupValue: valueoption,
              onChanged: (String? value) {
                setState(() {
                  valueoption = value!;
                });
              },
            ),
            Divider(color: ConstColors.dividerColor),

            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Female",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Female",
              groupValue: valueoption,
              onChanged: (String? value) {
                setState(() {
                  valueoption = value!;
                });
              },
            ),
            Divider(color: ConstColors.dividerColor),

            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Both",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Both",
              groupValue: valueoption,
              onChanged: (String? value) {
                setState(() {
                  valueoption = value!;
                });
              },
            ),
            Divider(color: ConstColors.dividerColor),
          ],
        ),
      ),
    );
  }
}
