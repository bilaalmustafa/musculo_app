import 'package:flutter/material.dart';
import 'package:musculo_app/core/constants/const_colors.dart';

class ParagraphText extends StatelessWidget {
  const ParagraphText({
    super.key,
    required this.isExpanded,
    required this.onTap,
    required this.text,
  });

  final bool isExpanded;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Create a TextPainter to measure the text
        final textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(fontSize: 13, color: ConstColors.grey7575),
          ),
          maxLines: 5,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        // Check if the text exceeds 5 lines
        final bool isTextOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              maxLines: isExpanded ? null : 5,
              overflow: isExpanded ? null : TextOverflow.fade,
              style: TextStyle(fontSize: 13, color: ConstColors.grey7575),
            ),
            if (isTextOverflowing ||
                isExpanded) // Show button only if text overflows or is expanded
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    isExpanded ? "View Less" : "View More...",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
