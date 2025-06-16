import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/add_workout/view_model/add_workout_veiw_model.dart';
import 'package:provider/provider.dart';

class TypeOfWorkout extends StatefulWidget {
  const TypeOfWorkout({super.key});

  @override
  State<TypeOfWorkout> createState() => _TypeOfWorkoutState();
}

class _TypeOfWorkoutState extends State<TypeOfWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Consumer<AddWorkoutVeiwModel>(
          builder: (context, vm, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PoppinsText(
                  text: "Select type of your workout",
                  fontSize: Sizes.s24,
                  fontWeight: TextWeight.semiBold,
                ),
                SizedBox(height: Sizes.s20),
                Divider(color: ConstColors.dividerColor),

                RadioListTile(
                  fillColor: WidgetStatePropertyAll(vm.isTypeofworkoutSelect ? ConstColors.red : ConstColors.black),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Without equipment",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                  ),
                  value: "Without equipment",
                  groupValue: vm.typeofworkout,
                  onChanged: (String? value) {
                    vm.typeofworkoutselect(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),

                RadioListTile(
                   fillColor: WidgetStatePropertyAll(vm.isTypeofworkoutSelect ? ConstColors.red : ConstColors.black),
                  activeColor: Colors.black,
                  title: PoppinsText(
                    text: "Stretching",
                    fontSize: Sizes.s14,
                    fontWeight: TextWeight.medium,
                  ),
                  value: "Stretching",
                  groupValue: vm.typeofworkout,
                  onChanged: (String? value) {
                   vm.typeofworkoutselect(value!);
                  },
                ),
                Divider(color: ConstColors.dividerColor),
              ],
            );
          },
        ),
      ),
    );
  }
}
