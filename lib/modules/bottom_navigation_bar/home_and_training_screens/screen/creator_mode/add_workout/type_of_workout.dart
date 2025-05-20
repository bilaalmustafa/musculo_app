import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class TypeOfWorkout extends StatefulWidget {
  const TypeOfWorkout({super.key});

  @override
  State<TypeOfWorkout> createState() => _TypeOfWorkoutState();
}

class _TypeOfWorkoutState extends State<TypeOfWorkout> {
  String valueoption = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          spacing: Sizes.s20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoppinsText(
              text: "Select type of your workout",
              fontSize: Sizes.s24,
              fontWeight: TextWeight.semiBold,
            ),
            Divider(color: ConstColors.dividerColor),

            RadioListTile(
              activeColor: Colors.black,
              title: PoppinsText(
                text: "Without equipment",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Without equipment",
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
                text: "Stretching",
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
              ),
              value: "Stretching",
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
