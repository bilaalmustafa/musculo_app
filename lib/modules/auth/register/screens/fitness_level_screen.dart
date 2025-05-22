import 'package:flutter/material.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/register/component/select_level_of_fitness.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

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
            padding: const EdgeInsets.all(25.0),
            child: Consumer<AuthViewModel>(
              builder: (context, vm, _) {
                return Column(
                  spacing: Sizes.s40,
                  children: [
                    SelectLevelOfFitness(
                     
                      fitnessLevel: vm.fitnessLevel,
                      value: "Beginner",
                      onChanged: (value) {
                        vm.setfitnesslevel(value!);
                      },
                    ),
                    SelectLevelOfFitness(
                     
                      fitnessLevel: vm.fitnessLevel,
                      value: "Experienced",
                      onChanged: (value) {
                        vm.setfitnesslevel(value!);
                      },
                    ),
                    SelectLevelOfFitness(
                      
                      fitnessLevel: vm.fitnessLevel,
                      value: "Advanced",
                      onChanged: (value) {
                        vm.setfitnesslevel(value!);
                      },
                    ),
                  ],
                );
              },
            ),)
          ],
        ),
      ),
    );
  }
}
