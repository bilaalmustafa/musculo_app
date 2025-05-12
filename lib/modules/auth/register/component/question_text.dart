import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({super.key, required this.questionText});
  final String questionText;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: PoppinsText(
        text: questionText,
        fontSize: Sizes.s24,
        fontWeight: TextWeight.semiBold,
      ),
    );
  }
}
