import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get screenwidth => MediaQuery.sizeOf(this).width;
  double get screenheight => MediaQuery.sizeOf(this).height;
}
//  String? format() {
//     if (this == null) {
//       return null;
//     }
//     return DateFormat("d, MMMM yy").format(DateTime.fromMicrosecondsSinceEpoch(this!));
//   }