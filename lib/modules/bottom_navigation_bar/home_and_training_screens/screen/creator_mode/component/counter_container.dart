import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/model/video_model.dart';

class CounterContainer extends StatefulWidget {
  int intervalSeconds;
  final Color? boxColor;
  final Function(int newSeconds)? onChanged;

  CounterContainer({
    super.key,
    required this.intervalSeconds,
    this.boxColor,
    this.onChanged,
  });

  @override
  State<CounterContainer> createState() => _CounterContainerState();
}

class _CounterContainerState extends State<CounterContainer> {
  late int intervalSeconds;

  @override
  void initState() {
    super.initState();
    intervalSeconds = widget.intervalSeconds;
  }

  void _incrementTime() {
    setState(() {
      intervalSeconds += 5;
      widget.onChanged!(intervalSeconds);
    });
  }

  void _decrementTime() {
    if (intervalSeconds > 0) {
      setState(() {
        intervalSeconds = (intervalSeconds - 5).clamp(5, intervalSeconds);
        widget.onChanged!(intervalSeconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = intervalSeconds ~/ 60;
    final int seconds = intervalSeconds % 60;
    final isWhite = widget.boxColor != null;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isWhite ? ConstColors.white : ConstColors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(_decrementTime);
                },
                child: Icon(
                  Icons.remove,
                  color: isWhite ? ConstColors.black : ConstColors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              PoppinsText(
                text:
                    "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                fontSize: 12,
                color: isWhite ? ConstColors.black : ConstColors.white,
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(_incrementTime);
                },
                child: Icon(
                  Icons.add,
                  color: isWhite ? ConstColors.black : ConstColors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
