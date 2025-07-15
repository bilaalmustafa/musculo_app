import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/model/programs_model.dart';

import '../../programs_and_workout/component/program_item_dis.dart';

class Programs extends StatelessWidget {
  const Programs({
    super.key,
    required this.tabselect,
    required this.programModelList,
  });
  final int tabselect;
  final List<ProgramModel> programModelList;

  @override
  Widget build(BuildContext context) {
    final programList = programModelList;

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
                  return ProgramItemDis(program: programList[index]);
                },
              ),
    );
  }
}
