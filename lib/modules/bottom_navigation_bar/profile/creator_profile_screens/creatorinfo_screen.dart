import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/share_picture.dart';
import '../../../../components/shared_appbar.dart';
import '../../../../core/config/routes.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/const_colors.dart';
import '../component/customdropdown.dart';

class CreatorinfoScreen extends StatefulWidget {
  const CreatorinfoScreen({super.key});

  @override
  State<CreatorinfoScreen> createState() => _CreatorinfoScreenState();
}

class _CreatorinfoScreenState extends State<CreatorinfoScreen> {
  String _selectExcercise = '';
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Become a Creator'),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.s15,
          children: [
            Center(
              child: SizedBox(
                height: Sizes.s120,
                width: Sizes.s300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 55,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: Sizes.s50,
                        color: Colors.black,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(40, 40),
                      child: InkWell(
                        onTap: () {
                          // edit code here
                        },
                        child: SharePicture(imagePath: Assets.eidtSquare),
                        // Container(
                        //   width: Sizes.s20,
                        //   height: Sizes.s20,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.rectangle,
                        //     borderRadius: BorderRadius.circular(4),
                        //     color: Colors.black,
                        //   ),
                        //   child: Icon(
                        //     Icons.edit,
                        //     color: Colors.white,
                        //     size: Sizes.s20,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(title: "Full Name"),
            CustomTextField(title: "Overview"),
            CustomTextField(title: "Experience"),
            CustomTextField(title: "Goal"),
            CustomDropdown(
              value: _selectExcercise,
              items: const [
                'Incline Dumbbell Press',
                'Bench Press',
                'Push-Ups',
                'Upper Body',
              ],
              hint: 'Select Excercise',
              onChanged: (value) {
                setState(() {
                  _selectExcercise = value;
                });
              },
            ),

            SizedBox(
              child: CheckboxListTile(
                title: PoppinsText(
                  text:
                      'By becoming a creator, you are agree with our Terms of Services and Privacy Policy.',
                  fontSize: Sizes.s10,
                  fontWeight: FontWeight.w400,
                ),
                value: _isChecked,
                onChanged: (value) {
                  _isChecked = value!;
                  setState(() {});
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: ConstColors.black,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Sizes.s16),
        child: CustomButton(
          onTap: () {
            // navigation handle here
            Navigator.pushNamed(context, Routes.paymentScreen);
          },

          buttonText: 'Become a Creator',
        ),
      ),
    );
  }
}
