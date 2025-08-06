import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/auth/view_model/forgot_view_model.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifypasswordScreen extends StatefulWidget {
  const VerifypasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<VerifypasswordScreen> createState() => _VerifypasswordScreenState();
}

class _VerifypasswordScreenState extends State<VerifypasswordScreen> {
  String otp = '';
  Timer? _timer;
  int _remainingSeconds = 180;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _remainingSeconds = 180;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        setState(() {}); // Update UI to show resend
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;

    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            SharePicture(
              imagePath: Assets.mailDraw,
              width: Sizes.s230,
              height: Sizes.s200,
            ),
            const SizedBox(height: Sizes.s20),
            Center(
              child: PoppinsText(
                text: 'Code has been sent to\n$email',
                fontSize: Sizes.s14,
                fontWeight: TextWeight.medium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: Sizes.s16),
            Pinput(
              length: 4,
              onChanged: (value) => otp = value,
              defaultPinTheme: PinTheme(
                width: 70,
                height: 50,
                textStyle: const TextStyle(
                  fontSize: Sizes.s20,
                  color: ConstColors.black,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  color: ConstColors.greyEEE,
                  border: Border.all(color: ConstColors.greyA9A8),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
            const SizedBox(height: Sizes.s16),

            _remainingSeconds > 0
                ? PoppinsText(
                  text: 'Resend code in ${_formatTime(_remainingSeconds)}',
                  fontSize: Sizes.s14,
                  fontWeight: TextWeight.medium,
                )
                : TextButton(
                  onPressed: () async {
                    final vm = context.read<PasswordResetProvider>();
                    final success = await vm.sendOtp(email);
                    if (success) {
                      Fluttertoast.showToast(msg: 'OTP resent successfully');
                      _startCountdown();
                    } else {
                      Fluttertoast.showToast(msg: 'Failed to resend OTP');
                    }
                  },
                  child: const Text('Resend OTP'),
                ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Consumer<PasswordResetProvider>(
          builder: (context, vm, _) {
            return CustomButton(
              loading: vm.isverified,
              onTap: () async {
                bool isVerified = await vm.verifyPasswordResetOTP(email, otp);
                if (isVerified && context.mounted) {
                  Navigator.pushNamed(context, Routes.changePasswordScreen
                      , arguments: {'email': email, 'otp': otp});
                } else {
                  Fluttertoast.showToast(
                    msg: "Verification failed. Please try again.",
                  );
                }
              },
              buttonText: 'Verify',
            );
          },
        ),
      ),
    );
  }
}
