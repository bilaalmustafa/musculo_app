import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/register/component/select_level_of_fitness.dart';

class FitnessLevelScren extends StatefulWidget {
  const FitnessLevelScren({super.key});

  @override
  State<FitnessLevelScren> createState() => _FitnessLevelScrenState();
}

class _FitnessLevelScrenState extends State<FitnessLevelScren> {
  String selectedFitnessLevel = "Beginner";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Container(
              height: Sizes.s80,
              width: double.infinity,
              color: ConstColors.white,
              child: QuestionText(
                questionText: "What is your current fitness level?",
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(Sizes.s16),
              child: Column(
                spacing: Sizes.s40,
                children: [
                  SelectLevelOfFitness(
                    color:
                        selectedFitnessLevel == "Beginner"
                            ? ConstColors.black
                            : ConstColors.white,
                    fitnessLevel: "Beginner",
                    value: "Beginner",
                    groupValue: selectedFitnessLevel,
                    onChanged: (value) {
                      setState(() {
                        selectedFitnessLevel = value!;
                      });
                    },
                  ),
                  SelectLevelOfFitness(
                    color:
                        selectedFitnessLevel == "Experienced"
                            ? ConstColors.black
                            : ConstColors.white,
                    fitnessLevel: "Experienced",
                    value: "Experienced",
                    groupValue: selectedFitnessLevel,
                    onChanged: (value) {
                      setState(() {
                        selectedFitnessLevel = value!;
                      });
                    },
                  ),
                  SelectLevelOfFitness(
                    color:
                        selectedFitnessLevel == "Advanced"
                            ? ConstColors.black
                            : ConstColors.white,
                    fitnessLevel: "Advanced",
                    value: "Advanced",
                    groupValue: selectedFitnessLevel,
                    onChanged: (value) {
                      setState(() {
                        selectedFitnessLevel = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
