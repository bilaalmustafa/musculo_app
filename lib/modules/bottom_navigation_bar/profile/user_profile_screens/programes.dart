import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/programItems.dart';
import 'package:provider/provider.dart';

import '../../programs_and_workout/component/program_item.dart';

class Programs extends StatelessWidget {
  Programs({
    super.key,
    required this.tabselect,
    required this.programModelList,
  });
  final int tabselect;
  List<ProgramModel> programModelList;

  @override
  Widget build(BuildContext context) {
    final programList = programModelList;
    // final userVm = context.read<UserViewModel>();
    // final programList = userVm.userModel?.listOfPrograms ?? [];

    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body:
          programList.isEmpty
              ? Center(
                child: Text(
                  "No Programs",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              )
              : ListView.builder(
                itemCount: programList.length,
                itemBuilder: (context, index) {
                  return ProgramItemDis(
                    tabselect: tabselect,
                    program: programList[index],
                  );
                },
              ),
    );
  }
}
