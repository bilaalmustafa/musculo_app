import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/validator.dart';
import 'package:musculo_app/core/constants/assets.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/components/feedbackfield.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/feedback/view_model/report_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/logo_title_appbar.dart';
import '../../../auth/register/component/show_dialog_box.dart';
import '../../home_and_training_screens/view_model/user_view_model.dart';

class Reportstab extends StatefulWidget {
  const Reportstab({
    super.key,
    required this.reportType,
    this.contentId,
    this.rating,
    this.contentName,
  });
  final String reportType;
  final String? contentId;
  final double? rating;
  final String? contentName;

  @override
  State<Reportstab> createState() => _ReportstabState();
}

class _ReportstabState extends State<Reportstab> {
  final noteController = TextEditingController();
  final emailController = TextEditingController();
  final otherReasonController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final List<String> reasons = [
    'Repetitive training',
    'Hate speech',
    'Sexual descriptions/expressions',
    'False descriptions/ information',
    'Selling another product',
    'Other',
  ];
  @override
  void dispose() {
    noteController.dispose();
    emailController.dispose();
    otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>().userModel;
    return Scaffold(
      appBar: LogoTitleAppBar(title: widget.reportType),
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          child: Consumer<ReportProvider>(
            builder: (context, provider, child) {
              return Form(
                key: formkey,
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
                                groupValue: provider.selectReason,
                                onChanged: (value) {
                                  provider.setSelectReason(value!);
                                  if (value != 'Other') {
                                    otherReasonController.clear();
                                    // provider.setOtherReason('');
                                  }
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
                          if (reason == "Other" &&
                              provider.selectReason == "Other")
                            Feedbackfield(
                              controller: otherReasonController,
                              hint: 'Give Other Reason',
                              height: Sizes.s90,
                              maxline: 3,
                              validator:
                                  (value) => Validator.valueExists(value),
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
                      validator: (value) => Validator.emailValidate(value),
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
              );
            },
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ReportProvider>(
          builder: (context, provider, child) {
            return CustomButton(
              loading: provider.isLoading,
              onTap: () async {
                if (provider.selectReason == null ||
                    provider.selectReason!.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'Please select a reason for reporting',
                  );
                  return;
                }

                // SECOND: If "Other" is selected, check if other reason is provided
                if (provider.selectReason == 'Other' &&
                    otherReasonController.text.trim().isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'Please specify the other reason',
                  );
                  return;
                }

                if (formkey.currentState!.validate()) {
                  await provider.submitReport(
                    userId: userViewModel?.userId ?? 'anonoymous',
                    contentId: widget.contentId ?? "unknown",
                    rating: widget.rating ?? 0.0,
                    contentName: widget.contentName ?? "unknown",
                    userName: userViewModel?.name ?? 'Anonymous',
                    contentType: widget.reportType,
                    note: noteController.text.toString().trim(),
                    email: emailController.text.toString().trim(),
                    otherReason: otherReasonController.text.toString().trim(),
                  );

                  if (context.mounted) {
                    formkey.currentState?.reset();
                    emailController.clear();
                    noteController.clear();
                    otherReasonController.clear();
                    provider.clearSelectReason();

                    Fluttertoast.showToast(msg: 'Report submitted');

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
                  }
                }
              },

              buttonText: 'Send Report',
            );
          },
        ),
      ),
    );
  }
}
