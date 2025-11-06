import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/custom_button.dart';

import '../../../../components/shared_appbar.dart';
import '../../../../core/config/routes.dart';

import '../../../../core/constants/const_colors.dart';

class CreatorinfoScreen extends StatefulWidget {
  const CreatorinfoScreen({super.key});

  @override
  State<CreatorinfoScreen> createState() => _CreatorinfoScreenState();
}

class _CreatorinfoScreenState extends State<CreatorinfoScreen> {
  bool _isChecked = false;
  final GlobalKey<FormState> _formlKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Become a Creator'),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Sizes.s15,
            children: [
              // Center(
              //   child: SizedBox(
              //     height: Sizes.s120,
              //     width: Sizes.s300,
              //     child: Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         CircleAvatar(
              //           maxRadius: 55,
              //           backgroundColor: Colors.grey[200],
              //           child: Icon(
              //             Icons.person,
              //             size: Sizes.s50,
              //             color: Colors.black,
              //           ),
              //         ),
              //         Transform.translate(
              //           offset: Offset(40, 40),
              //           child: InkWell(
              //             onTap: () {
              //               // edit code here
              //             },
              //             child: SharePicture(imagePath: Assets.eidtSquare),
              //             // Container(
              //             //   width: Sizes.s20,
              //             //   height: Sizes.s20,
              //             //   decoration: BoxDecoration(
              //             //     shape: BoxShape.rectangle,
              //             //     borderRadius: BorderRadius.circular(4),
              //             //     color: Colors.black,
              //             //   ),
              //             //   child: Icon(
              //             //     Icons.edit,
              //             //     color: Colors.white,
              //             //     size: Sizes.s20,
              //             //   ),
              //             // ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Form(
                key: _formlKey,
                child: Consumer<ProfileProvider>(
                  builder: (context, vm, _) {
                    return Column(
                      spacing: 10,
                      children: [
                        CustomTextField(
                          controller: vm.nameController,
                          title: "Full Name",
                          validator: (value) => Validator.valueExists(value),
                        ),
                        CustomTextField(
                          controller: vm.overviewController,
                          title: "Overview",
                          validator: (value) => Validator.valueExists(value),
                        ),
                        CustomTextField(
                          controller: vm.expController,
                          title: "Experience",
                          validator: (value) => Validator.valueExists(value),
                        ),
                        CustomTextField(
                          controller: vm.goalController,
                          title: "Goal",
                          validator: (value) => Validator.valueExists(value),
                        ),
                      ],
                    );
                  },
                ),
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
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Sizes.s16),
        child: Consumer<ProfileProvider>(
          builder: (context, vm, _) {
            return CustomButton(
              buttonColor: _isChecked ? ConstColors.black : ConstColors.gre9E9E,
              onTap:
                  _isChecked
                      ? () {
                        if (_formlKey.currentState!.validate()) {
                          if (vm.selectPlan == 0) {
                            Navigator.pushNamed(
                              context,
                              Routes.paymentScreen,
                              arguments: {'planType': 'Basic'},
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              Routes.paymentScreen,
                              arguments: {'planType': 'Premium'},
                            );
                          }
                          // if (vm.selectPlan == 0) {
                          //   showDialog(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     barrierColor: Colors.black.withValues(alpha: 0.9),
                          //     builder: (BuildContext context) {
                          //       return ShowDialogBox(
                          //         message:
                          //             'You are now a creator, start selling workouts and programs.',
                          //         bottomWidget: CustomButton(
                          //           buttonText: 'Back',
                          //           textColor: ConstColors.black,
                          //           buttonColor: ConstColors.secondary,
                          //           onTap: () {
                          //             Navigator.pushNamed(
                          //               context,
                          //               Routes.bottomnavigationbarscreen,
                          //             );
                          //           },
                          //         ),
                          //       );
                          //     },
                          //   );
                          // }
                          // else {
                          //   Navigator.pushNamed(context, Routes.paymentScreen);
                          // }
                        }
                      }
                      : null,

              buttonText: 'Become a Creator',
            );
          },
        ),
      ),
    );
  }
}
