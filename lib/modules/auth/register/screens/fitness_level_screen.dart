import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/modules/auth/register/widgets/question_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/register/widgets/select_level_of_fitness.dart';

class FitnessLevelScren extends StatelessWidget {
  const FitnessLevelScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Container(
            height: Sizes.s100,
            width: double.infinity,
            color: ConstColors.white,
            child: QuestionText(
              questionText: "What is your current fitness level?",
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              spacing: Sizes.s40,
              children: [
                SelectLevelOfFitness(
                  color: ConstColors.black,
                  fitnessLevel: "Beginner",
                  value: "Beginner",
                  onChanged: (value) {
                    // Handle selection
                  },
                ),
                SelectLevelOfFitness(
                  color: ConstColors.white,
                  fitnessLevel: "Experienced",
                  value: "Experienced",
                  onChanged: (value) {
                    // Handle selection
                  },
                ),
                SelectLevelOfFitness(
                  color: ConstColors.white,
                  fitnessLevel: "Advanced",
                  value: "Advanced",
                  onChanged: (value) {
                    // Handle selection
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
