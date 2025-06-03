import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/poppins_text.dart';
import '../../../../core/config/validator.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/constants/sizes.dart';
import '../../feedback/components/feedbackfield.dart';

class MotivationalTextScreen extends StatefulWidget {
  const MotivationalTextScreen({super.key});

  @override
  State<MotivationalTextScreen> createState() => _MotivationalTextScreenState();
}

class _MotivationalTextScreenState extends State<MotivationalTextScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Motivational Text'),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            PoppinsText(
              text: "Title",
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            Feedbackfield(
              controller: titleController,
              hint: 'Enter Title',
              height: 60,
              validator: (value) => Validator.valueExists(value),
            ),
            SizedBox(height: 30),
            PoppinsText(
              text: "Description",
              fontSize: Sizes.s16,
              fontWeight: TextWeight.semiBold,
            ),
            Feedbackfield(
              controller: descriptionController,
              hint: 'Enter description',
              maxline: 5,
              validator: (value) => Validator.valueExists(value),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: Sizes.s10,
          children: [
            Expanded(
              child: CustomButton(
                buttonText: 'Clear',
                textColor: Colors.black,
                buttonColor: ConstColors.secondary,

                onTap: () {
                  // logout logic here
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: CustomButton(
                buttonText: 'Add',
                onTap: () {
                  // add logic here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
