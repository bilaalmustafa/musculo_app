import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/auth/view_model/auth_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/shared_appbar.dart';
import '../../../../core/config/routes.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../auth/register/component/show_dialog_box.dart';
import 'package:pay/pay.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? _selectpay;
  bool _gpaySuccess = false;
  PaymentConfiguration? gpayConfig, applepayConfig;
  final _paymentItems = const [
    PaymentItem(
      label: 'Premium Plan',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _loadGPayConfig();
    _loadApplePayConfig();
  }

  Future<void> _loadGPayConfig() async {
    try {
      final jsonString = await rootBundle.loadString('assets/gPay.json');
      final config = PaymentConfiguration.fromJsonString(jsonString);
      setState(() {
        gpayConfig = config;
      });
    } catch (e) {
      log('Failed to load GPay config: $e');
    }
  }

  Future<void> _loadApplePayConfig() async {
    try {
      final jsonString = await rootBundle.loadString('assets/applePay.json');
      final config = PaymentConfiguration.fromJsonString(jsonString);
      setState(() {
        applepayConfig = config;
      });
    } catch (e) {
      log('Failed to load GPay config: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Payment Method'),
      body: Padding(
        padding: EdgeInsets.all(Sizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Sizes.s20,
          children: [
            if (gpayConfig != null)
              GooglePayButton(
                paymentConfiguration: gpayConfig!,
                paymentItems: _paymentItems,
                type: GooglePayButtonType.pay,
                theme: GooglePayButtonTheme.light,
                onPaymentResult: (data) {
                  log('Google Pay Resultt: $data');
                  setState(() {
                    _gpaySuccess = true;
                  });
                  _handlePostPaymentFlow(data);
                },
                loadingIndicator: const CircularProgressIndicator(),
                margin: const EdgeInsets.only(top: 15),
                height: 80,
                width: double.infinity,
              )
            else
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            if (applepayConfig != null)
              ApplePayButton(
                paymentConfiguration: applepayConfig!,
                paymentItems: _paymentItems,
                style: ApplePayButtonStyle.black,
                type: ApplePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                height: 50,
                width: double.infinity,
                onPaymentResult: (data) {
                  log('Apple Pay Result: $data');
                  _handlePostPaymentFlow(data);
                },
                loadingIndicator: const CircularProgressIndicator(),
              )
            else
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            // GestureDetector(
            //   onTap: () {
            //     _selectpay = 1;
            //     setState(() {});
            //   },
            //   child: Container(
            //     height: Sizes.s90,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         width: 1,
            //         color:
            //             _selectpay == 1 ? Colors.black : Colors.grey.shade300,
            //       ),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Row(
            //       spacing: Sizes.s20,
            //       children: [
            //         SizedBox(width: 0),
            //         SharePicture(
            //           imagePath: Assets.ellipse,
            //           width: Sizes.s50,
            //           height: Sizes.s50,
            //         ),
            //         PoppinsText(
            //           text: 'Apple Pay',
            //           fontSize: Sizes.s18,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.all(16),
      //   child: Consumer<ProfileProvider>(
      //     builder: (context, vm, _) {
      //       return CustomButton(loading: vm.isLoading, buttonText: 'Continues');
      //     },
      //   ),
      // ),
    );
  }

  Future<void> _handlePostPaymentFlow(Map<String, dynamic> data) async {
    final creator = context.read<UserViewModel>().userModel;
    if (creator != null) {
      final profileProvider = context.read<ProfileProvider>();

      final createdsuccess = await profileProvider.creatorPremiumPlane(
        creator.userId!,
        creator.email!,
        data['paymentMethodData']['info']['cardNetwork'] ?? 'N/A',
        9.99,
      );
      if (!createdsuccess) {
        Fluttertoast.showToast(msg: "Failed to record premium plan.");
        return;
      }
      final UserModel? success = await profileProvider.getCreatorPlan(
        creator.userId!,
      );
      if (success != null && context.mounted) {
        showDialog(
          barrierDismissible: false,
          context: context,
          barrierColor: Colors.black.withAlpha(230),
          builder:
              (_) => ShowDialogBox(
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
              ),
        );
      }
    }
  }
}
