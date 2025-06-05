import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/motivational_view_model.dart';

import 'package:provider/provider.dart';

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
  final formKey = GlobalKey<FormState>();

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
      appBar: SharedAppBar(title: 'Add Quote'),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
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
                height: 80,

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
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MotivationalTextProvider>(
          builder: (context, provider, child) {
            return Row(
              spacing: Sizes.s10,
              children: [
                // Expanded(
                //   child: CustomButton(
                //     loading: provider.isLoading,
                //     buttonText: 'Clear',
                //     textColor: Colors.black,
                //     buttonColor: ConstColors.secondary,

                //     onTap: () {
                //       // formKey.currentState?.reset();
                //       // titleController.clear();
                //       // descriptionController.clear();
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => MotivationalListScreen(),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Expanded(
                  child: CustomButton(
                    loading: provider.isLoading,
                    buttonText: 'Add',
                    onTap: () async {
                      // add logic here
                      if (formKey.currentState!.validate()) {
                        await provider.submitMotivationalText(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          userId: AuthService().currentUser!.uid,
                        );
                        formKey.currentState?.reset();
                        titleController.clear();
                        descriptionController.clear();

                        Fluttertoast.showToast(msg: 'successfully added');
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
