import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class PlanListTile extends StatelessWidget {
  final String text;
  const PlanListTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.check),
      title: PoppinsText(
        text: text,
        fontSize: Sizes.s16,
        fontWeight: TextWeight.regular,
      ),
    );
  }
}
