import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CarasoulContainer extends StatefulWidget {
  const CarasoulContainer({super.key});

  @override
  State<CarasoulContainer> createState() => _CarasoulContainerState();
}

class _CarasoulContainerState extends State<CarasoulContainer> {
  int _currentIndex = 0;
  final List<Map<String, String>> imgList = [
    {
      "title": "Be patient",
      "subtitle": "The greater the patience the greater the results!",
    },
    {
      "title": "Be respected",
      "subtitle": "The greater the patience the greater the results!",
    },
    {
      "title": "Be motivated",
      "subtitle": "The greater the patience the greater the results!",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CarouselSlider(
            options: CarouselOptions(
              height: Sizes.s180,
              viewportFraction: 1.0,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items:
                imgList
                    .map(
                      (item) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),

                        decoration: BoxDecoration(
                          color: ConstColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(Assets.bgimage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PoppinsText(
                                      text: item["title"]!,
                                      fontSize: 20,
                                      fontWeight: TextWeight.semiBold,
                                    ),
                                    PoppinsText(
                                      text: item["subtitle"]!,
                                      fontSize: Sizes.s11,
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(Assets.man, height: 150),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        Positioned(
          bottom: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                imgList.asMap().entries.map((entry) {
                  return Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == entry.key
                              ? ConstColors.black
                              : ConstColors.greyA9A8,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
