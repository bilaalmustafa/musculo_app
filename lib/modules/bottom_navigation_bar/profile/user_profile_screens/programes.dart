import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/model/programs_%20model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/component/programItems.dart';
import 'package:provider/provider.dart';

class Programs extends StatelessWidget {
  const Programs({super.key, required this.tabselect});
  final int tabselect;

  @override
  Widget build(BuildContext context) {
    final userVm = context.read<UserViewModel>();
    final programList = userVm.userModel?.listOfPrograms ?? [];

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
                  return ProgramItems(
                    tabselect: tabselect,
                    programModel: programList[index],
                  );
                },
              ),
    );
  }
}
