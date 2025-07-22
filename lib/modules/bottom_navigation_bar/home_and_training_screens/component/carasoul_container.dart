import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:provider/provider.dart';

import '../../profile/profile_view_model/motivational_view_model.dart';

class CarasoulContainer extends StatefulWidget {
  const CarasoulContainer({super.key});

  @override
  State<CarasoulContainer> createState() => _CarasoulContainerState();
}

class _CarasoulContainerState extends State<CarasoulContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MotivationalTextProvider>(
        context,
        listen: false,
      ).fetchRandomMotivationalTexts(limit: 5); // You can increase limit
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MotivationalTextProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CustomShimmer(height: 150));
        }

        if (provider.motivationalTexts.isEmpty) {
          return const Center(child: Text("No motivational texts found."));
        }
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
                    provider.setCurrentIndex(index);
                  },
                ),
                items:
                    provider.motivationalTexts
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PoppinsText(
                                          text: item.title ?? 'No Title',
                                          fontSize: 20,
                                          fontWeight: TextWeight.semiBold,
                                        ),
                                        PoppinsText(
                                          text:
                                              item.description ?? 'No Message',
                                          fontSize: Sizes.s11,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                        Assets.man,
                                        height: 150,
                                      ),
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
                    provider.motivationalTexts.asMap().entries.map((entry) {
                      return Container(
                        width: provider.currentIndex == entry.key ? 20.0 : 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(12),
                          color:
                              provider.currentIndex == entry.key
                                  ? ConstColors.black
                                  : ConstColors.greyA9A8,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
