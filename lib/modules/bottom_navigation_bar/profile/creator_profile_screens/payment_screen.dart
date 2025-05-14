import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/shared_appbar.dart';
import '../../../../core/config/routes.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../auth/register/component/show_dialog_box.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? _selectpay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Payment Method'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: Sizes.s20,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectpay = 0;
                });
              },
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color:
                        _selectpay == 0 ? Colors.black : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  spacing: 20,
                  children: [
                    SizedBox(width: 0),
                    SharePicture(
                      imagePath: Assets.gpayment,
                      width: 50,
                      height: 50,
                    ),
                    PoppinsText(
                      text: 'Google Pay',
                      fontSize: Sizes.s18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectpay = 1;
                setState(() {});
              },
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color:
                        _selectpay == 1 ? Colors.black : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  spacing: 20,
                  children: [
                    SizedBox(width: 0),
                    SharePicture(
                      imagePath: Assets.ellipse,
                      width: 50,
                      height: 50,
                    ),
                    PoppinsText(
                      text: 'Apple Pay',
                      fontSize: Sizes.s18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: CustomButton(
          onTap:
              _selectpay != null
                  ? () {
                    // navigation handle here
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withValues(alpha: 0.9),
                      builder: (BuildContext context) {
                        return ShowDialogBox(
                          message:
                              'You are now a creator, start selling workouts and programs.',
                          bottomWidget: CustomButton(
                            buttonText: 'Back',
                            textColor: ConstColors.black,
                            buttonColor: ConstColors.secondary,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.bottomnavigationbarscreen,
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  : null,

          buttonText: 'Continues',
        ),
      ),
    );
  }
}
