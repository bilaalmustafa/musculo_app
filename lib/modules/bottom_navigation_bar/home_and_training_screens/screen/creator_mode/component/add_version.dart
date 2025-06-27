import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/component/show_sheet_bottom.dart';
import 'package:video_player/video_player.dart';

class AddVersion extends StatefulWidget {
  const AddVersion({
    super.key,
    required this.intervelTime,
    required this.videomodelData,
  });
  final int intervelTime;
  final VideoModel videomodelData;
  @override
  State<AddVersion> createState() => _AddVersionState();
}

class _AddVersionState extends State<AddVersion> {
  @override
  Widget build(BuildContext context) {
    final int minutes = widget.intervelTime ~/ 60;
    final int seconds = widget.intervelTime % 60;
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: ConstColors.white,
              isScrollControlled: true,
              context: context,

              builder: (context) {
                return ShowSheetBottom(selectedVideo: widget.videomodelData);
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
              text:
                  widget.videomodelData.versionList.isNotEmpty
                      ? "${widget.videomodelData.versionList.length.toString()} Version"
                      : "Add Version",
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
            text:
                "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
            fontSize: 10,
            color: ConstColors.white,
          ),
        ),
      ],
    );
  }
}
