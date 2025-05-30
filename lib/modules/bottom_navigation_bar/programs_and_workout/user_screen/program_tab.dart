import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/program_item.dart';

class ProgramTab extends StatefulWidget {
  const ProgramTab({super.key, required this.tabselect});
  final int tabselect;

  @override
  State<ProgramTab> createState() => _ProgramTabState();
}

class _ProgramTabState extends State<ProgramTab> {
  Stream<List<ProgramModel>>? stream;

  @override
  @override
  void initState() {
    stream = instance<CreatorServices>().getPrograms();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: StreamBuilder<List<ProgramModel>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: PoppinsText(
                text: "No Programs Found",
                fontSize: Sizes.s16,
                color: ConstColors.black,
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: PoppinsText(
                text: "List is Empty",
                fontSize: Sizes.s16,
                color: ConstColors.black,
              ),
            );
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ProgramItem(
                tabselect: widget.tabselect,
                program: data[index],
              );
            },
          );
        },
      ),
    );
  }
}
