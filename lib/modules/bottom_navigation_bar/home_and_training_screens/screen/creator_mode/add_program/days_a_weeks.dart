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
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Sizes.s20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ).copyWith(top: 20),
            child: PoppinsText(
              text: "How many day’s a week ?",
              fontSize: Sizes.s20,
              fontWeight: TextWeight.semiBold,
            ),
          ),
          Expanded(
            child: Container(
              color: ConstColors.secondary,
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (conex, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: ConstColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          _selectedIndex == index
                              ? Border.all(color: ConstColors.black)
                              : null,
                    ),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(10),
                      checkboxShape: CircleBorder(
                        side: BorderSide(color: ConstColors.black),
                      ),
                      activeColor: ConstColors.black,
                      title: PoppinsText(
                        text: " ${index + 1} Time",
                        fontSize: Sizes.s14,
                      ),

                      value: _selectedIndex == index,
                      onChanged: (value) {
                        setState(() {
                          _selectedIndex = value! ? index : null;
                        });
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
