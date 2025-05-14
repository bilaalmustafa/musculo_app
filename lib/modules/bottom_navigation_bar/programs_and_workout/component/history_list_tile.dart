import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class HistoryListTile extends StatelessWidget {
  const HistoryListTile({super.key, required this.headingtext, required this.runtext, required this.timetext});
  final String headingtext, runtext, timetext;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: PoppinsText(
        text: headingtext,
        fontSize: Sizes.s14,
        fontWeight: TextWeight.semiBold,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.run_circle_outlined,
            size: Sizes.s18,
            color: Colors.redAccent,
          ),
          PoppinsText(text: runtext, fontSize: Sizes.s12),
          SizedBox(width: Sizes.s8),
          Icon(Icons.timelapse, size: Sizes.s18, color: Colors.green),
          PoppinsText(text: "$timetext mins", fontSize: Sizes.s12),
        ],
      ),
    );
  }
}
