import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:musculo_app/core/config/extensions.dart';

import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices _splashServices = SplashServices();
  @override
  initState() {
    _splashServices.splashFunction(context);
    // _goTo();
    super.initState();
    // Now, call the service that handles all the logic.
  }

  // _goTo() {
  //   Future.delayed(const Duration(milliseconds: 5000), () {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pushReplacementNamed(context, Routes.getStarted);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(Assets.logo),
                Positioned(
                  top: context.screenheight * 0.33,
                  left: context.screenwidth * 0.15,
                  child: Text(
                    "Improving life \nthrough regular exercise",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: ConstColors.black,
                      fontSize: Sizes.s20,
                      fontWeight: TextWeight.medium,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: context.screenheight * 0.3),

            CircularProgressIndicator(
              color: ConstColors.black,
              strokeWidth: Sizes.s2,
            ),
          ],
        ),
      ),
    );
  }
}
