import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';

import 'package:musculo_app/core/constants/const_colors.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.listITems,
    required this.onChange,
    required this.value,
    this.validator,
  });

  final List<String> listITems;
  final ValueChanged onChange;
  final String? value;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: ConstColors.secondary,
      validator: validator,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ConstColors.black, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ConstColors.secondary),
        ),
        filled: true,
        fillColor: ConstColors.secondary,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ConstColors.secondary),
        ),
      ),
      hint: PoppinsText(
        text: "Select it here",
        fontSize: 10,
        color: ConstColors.greyA1A1,
      ),
      items:
          listITems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: PoppinsText(
                text: item,
                fontSize: 14,
                color: ConstColors.black,
              ), // or use your custom widget
            );
          }).toList(),
      value: value,

      onChanged: (value) {
        onChange(value!);
      },
    );
  }
}
