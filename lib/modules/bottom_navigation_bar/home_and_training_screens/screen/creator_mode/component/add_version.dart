import 'package:flutter/material.dart';
import 'package:musculo_app/components/customTextField.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/reels_item.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/show_sheet_bottom.dart';
import 'package:video_player/video_player.dart';

class AddVersion extends StatefulWidget {
  const AddVersion({super.key});

  @override
  State<AddVersion> createState() => _AddVersionState();
}

class _AddVersionState extends State<AddVersion> {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
  ];
  final List<VideoPlayerController> _controllers = [];
  @override
  void initState() {
    super.initState();
    for (var url in videoUrls) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      controller
          .initialize()
          .then((_) {
            print("Initialized video: $url");
            setState(() {});
          })
          .catchError((error) {
            print("Error initializing video: $error");
          });
      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: ConstColors.white,
              context: context,
              builder: (context) {
                return ShowSheetBottom(ListController: _controllers);
              },
            );
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: ConstColors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: PoppinsText(
              text: "Add Version",
              fontSize: 10,
              color: ConstColors.white,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: ConstColors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: PoppinsText(
            text: "01:00",
            fontSize: 10,
            color: ConstColors.white,
          ),
        ),
      ],
    );
  }
}
