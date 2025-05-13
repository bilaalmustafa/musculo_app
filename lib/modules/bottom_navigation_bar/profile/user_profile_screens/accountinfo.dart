import 'package:flutter/material.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../component/customdropdown.dart';

class AccountinfoScreen extends StatefulWidget {
  const AccountinfoScreen({super.key});

  @override
  State<AccountinfoScreen> createState() => _AccountinfoScreenState();
}

class _AccountinfoScreenState extends State<AccountinfoScreen> {
  String _selectedGender = 'Male';
  String _selectedLevel = 'Beginner';
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
            CustomTextField(title: "Name"),
            CustomTextField(
              title: "Date of Birth",

              suffexicon: Icons.calendar_month,
            ),
            CustomTextField(title: "Email", suffexicon: Icons.email_outlined),
            CustomDropdown(
              value: _selectedGender,
              items: const ['Male', 'Female', 'Other'],
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),

            // Level dropdown
            CustomDropdown(
              value: _selectedLevel,
              items: const ['Beginner', 'Intermediate', 'Advanced', 'Expert'],
              onChanged: (value) {
                setState(() {
                  _selectedLevel = value;
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
          buttonText: "Update",

          onTap: () {
            // Handle update
          },
        ),
      ),
    );
  }
}
