import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/assets.dart';

import 'package:musculo_app/modules/auth/register/component/gender_selection_button.dart';

import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Consumer<AuthViewModel>(
        builder: (context, vm, _) {
          return Column(
            spacing: Sizes.s40,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              QuestionText(questionText: "What is your gender?"),
              GenderSelectionButton(
                onTap: () {
                  vm.gender(true);
                },
                gendercolor:
                    vm.isMale ? ConstColors.black : ConstColors.secondary,
                gendertitle: "Male",
                gendericon: Icons.male,
              ),
              GenderSelectionButton(
                onTap: () {
                  vm.gender(false);
                },
                gendercolor:
                    vm.isMale ? ConstColors.secondary : ConstColors.black,
                gendertitle: "Female",
                // gendericon: Icons.female,
                gendericonimage: Assets.female,
              ),
            ],
          );
        },
      ),
    );
  }
}
