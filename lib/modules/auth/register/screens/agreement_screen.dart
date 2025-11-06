import 'package:flutter/material.dart';

import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/register/component/agreement_check.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';

class AgreementScreen extends StatefulWidget {
  final ValueChanged<bool>? onAllAgreed;
  const AgreementScreen({super.key, this.onAllAgreed});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  List<bool> agreementsChecked = [false, false, false, false];

  void _updateAgreement(int index, bool value) {
    setState(() {
      agreementsChecked[index] = value;
    });
    final allChecked = agreementsChecked.every((e) => e);
    widget.onAllAgreed?.call(allChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.s16),
      child: Column(
        // spacing: Sizes.s1_5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionText(
            questionText:
                "By checking the box, you agree to our terms and conditions.",
          ),
          SizedBox(height: Sizes.s20),
          for (int i = 0; i < agreementsChecked.length; i++)
            AgreementCheck(
              isSelected: false,
              title: "Consequat id porta nibh venenatis cras sed. $i",
              isChecked: agreementsChecked[i],
              onChanged: (value) => _updateAgreement(i, value ?? false),
            ),

          // AgreementCheck(
          //   isSelected: false,
          //   title: "Consequat id porta nibh venenatis cras sed. I",
          //   isChecked: agreementsChecked[0],
          //   onChanged: (value) {
          //     setState(() {
          //       agreementsChecked[0] = value!;
          //     });
          //   },
          // ),
          // AgreementCheck(
          //   isSelected: false,
          //   title: "Consequat id porta nibh venenatis cras sed. I",
          //   isChecked: agreementsChecked[1],
          //   onChanged: (value) {
          //     setState(() {
          //       agreementsChecked[1] = value!;
          //     });
          //   },
          // ),
          // AgreementCheck(
          //   isSelected: false,
          //   title: "Consequat id porta nibh venenatis cras sed. I",
          //   isChecked: agreementsChecked[2],
          //   onChanged: (value) {
          //     setState(() {
          //       agreementsChecked[2] = value;
          //     });
          //   },
          // ),
          // AgreementCheck(
          //   isSelected: false,
          //   title: "Consequat id porta nibh venenatis cras sed. I",
          //   isChecked: agreementsChecked[3],
          //   onChanged: (value) {
          //     setState(() {
          //       agreementsChecked[3] = value!;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
