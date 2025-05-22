import 'package:flutter/material.dart';
import 'package:musculo_app/modules/auth/register/component/age_selection.dart';
import 'package:musculo_app/modules/auth/register/component/question_text.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Sizes.s30,
        children: [
          QuestionText(questionText: "What is your age?"),

          SizedBox(
            height: context.screenheight * 0.6,
            width: double.infinity,
            child: Consumer<AuthViewModel>(
              builder: (context, vm, _) {
                return ListWheelScrollView(
                  // controller: loginController.scrollController,
                  onSelectedItemChanged: (val) {
                    vm.setage(val);
                    // loginController.getAge(val);
                  },
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: 90,
                  children: List.generate(
                    100,
                    (index) => Center(
                      child: SelectAge(
                        index: index,
                        isSelected: index == vm.selectedage,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
