import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/share_to_social.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShowShareBottomSheet extends StatelessWidget {
  final GlobalKey shareKey;
  const ShowShareBottomSheet({super.key, required this.shareKey});
  Future<String> captureAndSaveImage() async {
    RenderRepaintBoundary boundary =
        shareKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/share_image.png';
    final file = File(path);
    await file.writeAsBytes(pngBytes);
    return path;
  }

  Future<void> shareToSocail() async {
    String path = await captureAndSaveImage();
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(path)],
        text: "I completed my workout! 🏆💪",
        subject: "Workout Complete!",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.s20),
      child: Column(
        spacing: Sizes.s20,
        children: [
          Container(height: 3, width: 30, color: ConstColors.secondary),

          PoppinsText(
            text: "Share to",
            fontSize: Sizes.s20,
            fontWeight: TextWeight.semiBold,
          ),
          Divider(color: ConstColors.secondary, height: 2),
          ShareToSocial(ontap: () => shareToSocail()),
          Divider(color: ConstColors.secondary, height: 2),
          CustomButton(
            buttonText: "Back home",
            onTap: () {
              Navigator.pushNamed(context, Routes.bottomnavigationbarscreen);
            },
          ),
        ],
      ),
    );
  }
}
