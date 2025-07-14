import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class ShareToSocial extends StatelessWidget {
  const ShareToSocial({super.key, this.ontap, });
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    List<String> text = ["WhatsApp", "Twitter", "Facebook", "Instagram"];
    List<String> svg = [
      Assets.whatsappimage,
      Assets.twitterImage,
      Assets.facebook,
      Assets.instagramImage,
    ];
     
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(text.length, (index) {
        return Column(
          spacing: 4,
          children: [
            InkWell(
              onTap: ontap,
              child: SharePicture(imagePath: svg[index], height: 50)),
            PoppinsText(text: text[index], fontSize: Sizes.s8),
          ],
        );
      }),
    );
  }
}
