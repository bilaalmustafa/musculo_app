import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../../../../../auth/register/component/agreement_check.dart';

class SectionOfWork extends StatefulWidget {
  const SectionOfWork({super.key});

  @override
  State<SectionOfWork> createState() => _TypeOfWorkoutState();
}

class _TypeOfWorkoutState extends State<SectionOfWork> {
  List<bool> valueoption = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsText(
                text: "Select the sections of your workout",
                fontSize: Sizes.s24,
                fontWeight: TextWeight.semiBold,
              ),
              SizedBox(height: Sizes.s20),

              AgreementCheck(
                title: "Warm up",
                isChecked: valueoption[0],
                onChanged: (value) {
                  setState(() {
                    valueoption[0] = value!;
                  });
                },
              ),
              AgreementCheck(
                title: "Extended warm up",
                isChecked: valueoption[1],
                onChanged: (value) {
                  setState(() {
                    valueoption[1] = value!;
                  });
                },
              ),
              AgreementCheck(
                title: "Workout",
                isChecked: valueoption[2],
                onChanged: (value) {
                  setState(() {
                    valueoption[2] = value!;
                  });
                },
              ),
              AgreementCheck(
                title: "Finisher",
                isChecked: valueoption[3],
                onChanged: (value) {
                  setState(() {
                    valueoption[3] = value!;
                  });
                },
              ),
              AgreementCheck(
                title: "Cool down",
                isChecked: valueoption[4],
                onChanged: (value) {
                  setState(() {
                    valueoption[4] = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(Sizes.s16),
  //     child: Column(
  //       // spacing: Sizes.s1_5,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         QuestionText(
  //           questionText:
  //               "By checking the box, you agree to our terms and conditions.",
  //         ),
  //         SizedBox(height: Sizes.s20),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[0],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[0] = value!;
  //             });
  //           },
  //         ),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[1],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[1] = value!;
  //             });
  //           },
  //         ),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[2],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[2] = value;
  //             });
  //           },
  //         ),
  //         AgreementCheck(
  //           title: "Consequat id porta nibh venenatis cras sed. I",
  //           isChecked: agreementsChecked[3],
  //           onChanged: (value) {
  //             setState(() {
  //               agreementsChecked[3] = value!;
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }