import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/customTextField.dart';
import '../../../../components/share_picture.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/sizes.dart';
import '../../home_and_training_screens/view_model/user_view_model.dart';
import '../component/customdropdown.dart';

class Informationtab extends StatefulWidget {
  const Informationtab({super.key});

  @override
  State<Informationtab> createState() => _InformationtabState();
}

class _InformationtabState extends State<Informationtab> {
  final _formKey = GlobalKey<FormState>();
  late UserViewModel userVm;
  String _selectExcercise = '';
  String _selectPlan = '';
  late TextEditingController nameController;

  late TextEditingController overviewController;
  late TextEditingController experienceController;
  late TextEditingController goalController;
  @override
  void initState() {
    userVm = context.read<UserViewModel>();
    nameController = TextEditingController(text: userVm.userModel?.name ?? '');
    overviewController = TextEditingController(
      text: userVm.userModel?.overviewText ?? '',
    );
    experienceController = TextEditingController(
      text: userVm.userModel?.experienceText ?? '',
    );
    goalController = TextEditingController(
      text: userVm.userModel?.goalText ?? '',
    );
    _selectExcercise = userVm.userModel?.favExercise ?? '';
    _selectPlan = userVm.userModel?.subPlane ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    overviewController.dispose();
    experienceController.dispose();
    goalController.dispose();
    _selectExcercise = '';
    _selectPlan = '';

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = userVm.userModel;
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
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
                      backgroundImage:
                          data?.profileImageUrl != null
                              ? NetworkImage(data?.profileImageUrl ?? "")
                              : null,
                      child:
                          data?.profileImageUrl == null
                              ? Icon(
                                Icons.person,
                                size: Sizes.s50,
                                color: Colors.black,
                              )
                              : null,
                    ),
                    Transform.translate(
                      offset: Offset(40, 40),
                      child: InkWell(
                        onTap: () {
                          // edit code here
                        },
                        child: SharePicture(imagePath: Assets.eidtSquare),
                        //  Container(
                        //   width: Sizes.s20,
                        //   height: Sizes.s20,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.rectangle,
                        //     borderRadius: BorderRadius.circular(4),
                        //     color: Colors.black,
                        //   ),
                        //   child: Icon(Icons.edit, color: Colors.white, size: 20),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: nameController,
                title: "Full Name",
                validator: (value) => Validator.valueExists(value),
              ),
            ),
            CustomTextField(controller: overviewController, title: "Overview"),
            CustomTextField(
              controller: experienceController,
              title: "Experience",
            ),
            CustomTextField(controller: goalController, title: "Goal"),
            CustomDropdown(
              value: _selectExcercise,
              items: const [
                'Incline Dumbbell Press',
                'Bench Press',
                'Push-Ups',
                'Upper Body',
              ],
              hint: 'Select Favorites Excercise',
              onChanged: (value) {
                setState(() {
                  _selectExcercise = value;
                });
              },
            ),
            CustomDropdown(
              value: _selectPlan,
              items: const ['Free', 'Premium'],
              hint: 'Select Plan',
              onChanged: (value) {
                setState(() {
                  _selectPlan = value;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: CustomButton(
          loading: userVm.isLoading,
          buttonText: "Update",
          onTap: () async {
            // log("Updating User: ${widget.userModel.toString()}");

            if (_formKey.currentState!.validate()) {
              UserModel? updatedUser = await context
                  .read<UserViewModel>()
                  .updateUserData(
                    id: data!.userId!,
                    uname: nameController.text.trim(),
                    cOveriew: overviewController.text.trim(),
                    cExperience: experienceController.text.trim(),
                    cGoal: goalController.text.trim(),
                    cExercise: _selectExcercise,
                    cPlan: _selectPlan,
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
