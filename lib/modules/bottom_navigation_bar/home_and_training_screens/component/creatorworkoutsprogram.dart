import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

class CreatorWorkoutsProgramList<T> extends StatelessWidget {
  final Stream<List<T>> stream;
  final Widget Function(T item) itemBuilder;
  final String emptyMessage;
  final bool isInBottomSheet;

  const CreatorWorkoutsProgramList({
    super.key,

    required this.stream,
    required this.itemBuilder,
    required this.emptyMessage,
    this.isInBottomSheet = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomShimmer(height: 60));
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final items = snapshot.data ?? [];

        if (items.isEmpty) {
          return PoppinsText(
            text: emptyMessage,
            fontSize: Sizes.s16,
            color: ConstColors.greyA1A1,
          );
        }

        return ListView.separated(
          // padding: const EdgeInsets.all(16),
          shrinkWrap: !isInBottomSheet,
          physics:
              isInBottomSheet
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) => itemBuilder(items[index]),
          separatorBuilder: (_, __) => const SizedBox(height: Sizes.s15),
        );
      },
    );
  }
}
