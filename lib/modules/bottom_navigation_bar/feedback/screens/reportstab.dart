import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/components/feedbackfield.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/logo_title_appbar.dart';
import '../../../auth/register/component/show_dialog_box.dart';

class Reportstab extends StatefulWidget {
  const Reportstab({super.key, required this.reportType});
  final String reportType;

  @override
  State<Reportstab> createState() => _ReportstabState();
}

class _ReportstabState extends State<Reportstab> {
  String? selectedReason;
  String? otherReasonText;
  final noteController = TextEditingController();
  final emailController = TextEditingController();
  final otherReasonController = TextEditingController();

  final List<String> reasons = [
    'Repetitive training',
    'Hate speech',
    'Sexual descriptions/expressions',
    'False descriptions/ information',
    'Selling another product',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoTitleAppBar(title: widget.reportType),
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              PoppinsText(
                text: 'Select a reason',
                fontSize: Sizes.s16,
                fontWeight: TextWeight.regular,
              ),
              ...reasons.map((reason) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          activeColor: ConstColors.black,
                          value: reason,
                          groupValue: selectedReason,

                          onChanged: (value) {
                            setState(() {
                              selectedReason = value;
                              if (value != 'other') otherReasonText = '';
                            });
                          },
                        ),

                        Expanded(
                          child: PoppinsText(
                            text: reason,
                            fontSize: Sizes.s14,
                            fontWeight: TextWeight.regular,
                          ),
                        ),
                      ],
                    ),
                    // if the user select other then this field will be show
                    if (reason == "Other" && selectedReason == "Other")
                      Feedbackfield(
                        controller: otherReasonController,
                        hint: 'Give Other Reason',
                        height: Sizes.s90,
                        maxline: 3,
                        onchange: (value) {
                          setState(() {
                            otherReasonText = value;
                          });
                        },
                      ),
                  ],
                );
              }),

              // PoppinsText(
              //   text: 'To whom you report ',
              //   fontSize: Sizes.s14,
              //   fontWeight: TextWeight.semiBold,
              // ),
              // SizedBox(height: Sizes.s5),

              // CustomDropdown(
              //   value: null,
              //   items: ['Training', 'Program', 'Creator'],
              //   hint: 'Select training, Program, Creator',
              //   onChanged: (value) {},
              // ),
              SizedBox(height: Sizes.s10),
              Feedbackfield(
                controller: emailController,
                hint: 'Email ( Optional )',
                height: Sizes.s60,
                sufixIcon: Assets.message,
              ),
              SizedBox(height: Sizes.s10),
              Feedbackfield(
                controller: noteController,
                hint: 'Note ( Optional )',
                height: Sizes.s90,
                maxline: 3,
              ),
              SizedBox(height: Sizes.s20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onTap: () {
            // navigation handle here
            showDialog(
              context: context,
              barrierColor: Colors.black.withValues(alpha: 0.9),
              builder: (BuildContext context) {
                return ShowDialogBox(
                  title: 'Report Sent!',
                  message: 'Thank you for your feedback',
                  bottomWidget: CustomButton(
                    buttonText: 'Back',
                    textColor: ConstColors.white,
                    buttonColor: ConstColors.black,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },

          buttonText: 'Send Report',
        ),
      ),
    );
  }
}
