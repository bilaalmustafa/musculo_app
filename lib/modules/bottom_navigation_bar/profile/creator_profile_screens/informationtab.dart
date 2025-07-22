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
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ? NetworkImage(data!.profileImageUrl!)
                                      : null,
                              child:
                                  data?.profileImageUrl == null
                                      ? const Icon(
                                        Icons.person,
                                        size: Sizes.s50,
                                        color: Colors.black,
                                      )
                                      : null,
                            ),
                            Transform.translate(
                              offset: const Offset(40, 40),
                              child: InkWell(
                                onTap: () {},
                                child: SharePicture(
                                  imagePath: Assets.eidtSquare,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: nameController,
                      title: "Full Name",
                      validator: (value) => Validator.valueExists(value),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: overviewController,
                      title: "Overview",
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: experienceController,
                      title: "Experience",
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(controller: goalController, title: "Goal"),
                    const SizedBox(height: 15),
                    CustomDropdown(
                      value: _selectExcercise,
                      items: const [
                        'Incline Dumbbell Press',
                        'Bench Press',
                        'Push-Ups',
                        'Upper Body',
                      ],
                      hint: 'Select Favorite Excersice',
                      onChanged: (value) {
                        setState(() {
                          _selectExcercise = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 110), // reserve space above button
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
        child: CustomButton(
          loading: userVm.isLoading,
          buttonText: "Update",
          onTap: () async {
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
                print('............>$_selectExcercise');
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
