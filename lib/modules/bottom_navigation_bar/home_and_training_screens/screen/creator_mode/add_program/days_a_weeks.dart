import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class DaysAWeeks extends StatefulWidget {
  const DaysAWeeks({super.key});

  @override
  State<DaysAWeeks> createState() => _DaysAWeeksState();
}

class _DaysAWeeksState extends State<DaysAWeeks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        children: [
          PoppinsText(
            text: "What’s the duration of your program ",
            fontSize: Sizes.s20,
            fontWeight: TextWeight.semiBold,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (conex, index) {
                return CheckboxListTile(
                  title: PoppinsText(text: "1 Time", fontSize: Sizes.s14),

                  value: true,
                  onChanged: (value) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
