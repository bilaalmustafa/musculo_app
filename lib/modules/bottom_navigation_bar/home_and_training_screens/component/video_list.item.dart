import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                      width: Sizes.s80,
                      height: Sizes.s80,
                      decoration: BoxDecoration(
                        color: ConstColors.secondary,
                        borderRadius: BorderRadius.circular(Sizes.s10),
                        image: const DecorationImage(
                          image: AssetImage(Assets.workout),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: ConstColors.primary0769,
                                borderRadius: BorderRadius.circular(Sizes.s2),
                              ),
                              child: Icon(Icons.check, size: 12),
                            ),
                          ),
                        ],
                      ),
                    );
  }
}