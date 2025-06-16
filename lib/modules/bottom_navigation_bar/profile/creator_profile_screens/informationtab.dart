import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/share_picture.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/sizes.dart';
import '../component/customdropdown.dart';

class Informationtab extends StatefulWidget {
  const Informationtab({super.key});

  @override
  State<Informationtab> createState() => _InformationtabState();
}

class _InformationtabState extends State<Informationtab> {
  String _selectExcercise = '';
  String _selectPlan = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Sizes.s15,
        children: [
          Center(
            child: SizedBox(
              height: Sizes.s120,
              width: Sizes.s300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 55,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.person,
                      size: Sizes.s50,
                      color: Colors.black,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(40, 40),
                    child: InkWell(
                      onTap: () {
                        // edit code here
                      },
                      child: SharePicture(imagePath: Assets.eidtSquare),
                      //  Container(
                      //   width: Sizes.s20,
                      //   height: Sizes.s20,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     borderRadius: BorderRadius.circular(4),
                      //     color: Colors.black,
                      //   ),
                      //   child: Icon(Icons.edit, color: Colors.white, size: 20),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomTextField(title: "Full Name"),
          CustomTextField(title: "Overview"),
          CustomTextField(title: "Experience"),
          CustomTextField(title: "Goal"),
          CustomDropdown(
            value: _selectExcercise,
            items: const [
              'Incline Dumbbell Press',
              'Bench Press',
              'Push-Ups',
              'Upper Body',
            ],
            hint: 'Select Favorites Excercise',
            onChanged: (value) {
              setState(() {
                _selectExcercise = value;
              });
            },
          ),
          CustomDropdown(
            value: _selectPlan,
            items: const ['Free', 'Premium'],
            hint: 'Select Plan',
            onChanged: (value) {
              setState(() {
                _selectPlan = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
