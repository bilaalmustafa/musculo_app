import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class SectionOfWork extends StatefulWidget {
  const SectionOfWork({super.key});

  @override
  State<SectionOfWork> createState() => _TypeOfWorkoutState();
}

class _TypeOfWorkoutState extends State<SectionOfWork> {
  List<bool> valueoption = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: Sizes.s10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsText(
                text: "Select the sections of your workout",
                fontSize: Sizes.s20,
                fontWeight: TextWeight.semiBold,
              ),
              Divider(color: ConstColors.dividerColor),

              CheckboxListTile(
                activeColor: Colors.black,
                title: PoppinsText(
                  text: "Warm up",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                ),
                value: valueoption[0],

                onChanged: (value) {
                  setState(() {
                    valueoption[0] = value!;
                  });
                },
              ),
              Divider(color: ConstColors.dividerColor),

              CheckboxListTile(
                activeColor: Colors.black,
                title: PoppinsText(
                  text: "Extended warm up",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                ),
                value: valueoption[1],

                onChanged: (value) {
                  setState(() {
                    valueoption[1] = value!;
                  });
                },
              ),
              Divider(color: ConstColors.dividerColor),

              CheckboxListTile(
                activeColor: Colors.black,
                title: PoppinsText(
                  text: "Workout",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                ),
                value: valueoption[2],

                onChanged: (value) {
                  setState(() {
                    valueoption[2] = value!;
                  });
                },
              ),
              Divider(color: ConstColors.dividerColor),
              CheckboxListTile(
                activeColor: Colors.black,
                title: PoppinsText(
                  text: "Finisher",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                ),
                value: valueoption[3],

                onChanged: (value) {
                  setState(() {
                    valueoption[3] = value!;
                  });
                },
              ),
              Divider(color: ConstColors.dividerColor),
              CheckboxListTile(
                activeColor: Colors.black,
                title: PoppinsText(
                  text: "Cool down",
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                ),
                value: valueoption[4],

                onChanged: (value) {
                  setState(() {
                    valueoption[4] = value!;
                  });
                },
              ),
              Divider(color: ConstColors.dividerColor),
            ],
          ),
        ),
      ),
    );
  }
}
