import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/program_item.dart';

class ProgramTabDisScreen extends StatefulWidget {
  const ProgramTabDisScreen({super.key});

  @override
  State<ProgramTabDisScreen> createState() => _ProgramTabDisScreenState();
}

class _ProgramTabDisScreenState extends State<ProgramTabDisScreen> {
  Stream<List<ProgramModel>>? stream;
  @override
  void initState() {
    stream = instance<ProgramServices>().getPrograms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: StreamBuilder<List<ProgramModel>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
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
              return ProgramItemDis(program: data[index]);
            },
          );
        },
      ),
    );
  }
}
