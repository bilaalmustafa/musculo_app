import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../component/customdropdown.dart';

class AccountinfoScreen extends StatefulWidget {
  const AccountinfoScreen({super.key});

  @override
  State<AccountinfoScreen> createState() => _AccountinfoScreenState();
}

class _AccountinfoScreenState extends State<AccountinfoScreen> {
  late UserViewModel userViewModel;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;

  late TextEditingController dobController;
  DateTime? selectedDate;
  String selectedGender = '';
  String selectedLevel = '';
  String userEmail = '';
  @override
  void initState() {
    super.initState();
    userViewModel = context.read<UserViewModel>();
    final userModel = userViewModel.userModel!;

    nameController = TextEditingController(text: userModel.name ?? '');

    selectedGender = userModel.gender ?? '';
    selectedLevel = userModel.levelOfFitness ?? '';
    userEmail = userModel.email ?? "";
    selectedDate = userModel.dateOfBirth;
    dobController = TextEditingController(
      text:
          selectedDate != null
              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
              : '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Account Information'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: Sizes.s20,
          children: [
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: nameController,
                title: "Name",

                validator: (value) => Validator.valueExists(value),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),

                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary:
                              ConstColors
                                  .black, // selected date circle background
                          onPrimary:
                              ConstColors.white, // selected date text color
                          onSurface: ConstColors.black, // normal text color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                ConstColors
                                    .black, // OK/Cancel button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                    dobController.text =
                        "${picked.day}/${picked.month}/${picked.year}";
                  });
                }
              },
              child: AbsorbPointer(
                child: CustomTextField(
                  controller: dobController,
                  title: "Date of Birth",
                  sufIcon: Assets.calendar1,
                ),
              ),
            ),
            CustomTextField(
              title: userEmail,
              sufIcon: Assets.message1,
              enabled: false,
            ),
            CustomDropdown(
              value: selectedGender,
              items: const ['Male', 'Female', 'Other'],
              hint: 'Select Gender',
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),

            // Level dropdown
            CustomDropdown(
              value: selectedLevel,
              items: const ['Beginner', 'Intermediate', 'Advanced', 'Expert'],
              hint: 'select Level',
              onChanged: (value) {
                setState(() {
                  selectedLevel = value;
                });
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: CustomButton(
          loading: userViewModel.isLoading,
          buttonText: "Update",
          onTap: () async {
            // log("Updating User: ${widget.userModel.toString()}");

            if (_formKey.currentState!.validate()) {
              UserModel? updatedUser = await context
                  .read<UserViewModel>()
                  .updateUserData(
                    userViewModel.userModel!.userId!,
                    nameController.text.trim(),
                    selectedDate!,
                    selectedGender,
                    selectedLevel,
                  );

              if (updatedUser != null && context.mounted) {
                Fluttertoast.showToast(msg: "Updated Successfully");

                nameController.clear();
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(msg: "Updated Failed");
              }
            }
          },
        ),
      ),
    );
  }
}
