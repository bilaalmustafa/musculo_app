import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/const_colors.dart';

class ProgramTab extends StatefulWidget {
  const ProgramTab({super.key, required this.tabselect});
  final int tabselect;

  @override
  State<ProgramTab> createState() => _ProgramTabState();
}

class _ProgramTabState extends State<ProgramTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body:
      // StreamBuilder<List<ProgramModel>>(
      //   stream: stream,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (!snapshot.hasData || snapshot.data == null) {
      //       return Center(
      //         child: PoppinsText(
      //           text: "No Programs Found",
      //           fontSize: Sizes.s16,
      //           color: ConstColors.black,
      //         ),
      //       );
      //     }
      //     if (snapshot.data!.isEmpty) {
      //       return Center(
      //         child: PoppinsText(
      //           text: "List is Empty",
      //           fontSize: Sizes.s16,
      //           color: ConstColors.black,
      //         ),
      //       );
      //     }
      //     final data = snapshot.data!;
      //  return
      ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container();

          // ProgramItem(

          // );
        },
        // );
        // },
      ),
    );
  }
}
