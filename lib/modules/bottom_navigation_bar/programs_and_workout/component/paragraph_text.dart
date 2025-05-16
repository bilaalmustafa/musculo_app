import 'package:flutter/material.dart';

class ParagraphText extends StatelessWidget {
  const ParagraphText({
    super.key,
    required this.isExpanded,
    required this.onTap, required this.text,
  });
  final bool isExpanded;
  final String text;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: isExpanded ? null : 5,
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 13),
        ),
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
  }
}
