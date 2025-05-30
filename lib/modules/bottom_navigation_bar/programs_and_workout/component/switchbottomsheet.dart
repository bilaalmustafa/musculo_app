// import 'package:flutter/material.dart';

// import 'package:musculo_app/components/poppins_text.dart';
// import 'package:musculo_app/core/constants/const_colors.dart';
// import 'package:musculo_app/core/constants/sizes.dart';

// import '../../../auth/register/component/agreement_check.dart';

// class Switchbottomsheet extends StatefulWidget {
//   const Switchbottomsheet({super.key});

//   @override
//   State<Switchbottomsheet> createState() => _SwitchbottomsheetState();

//   static void show(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(Sizes.s40),
//           topRight: Radius.circular(Sizes.s40),
//         ),
//       ),
//       builder: (context) => const Switchbottomsheet(),
//     );
//   }
// }

// class _SwitchbottomsheetState extends State<Switchbottomsheet> {
//   bool selectValue = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 290,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(Sizes.s40),
//           topRight: Radius.circular(Sizes.s40),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 30),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: Sizes.s36,
//               height: Sizes.s3,
//               decoration: BoxDecoration(
//                 color: ConstColors.greyC4C4,
//                 borderRadius: BorderRadius.circular(Sizes.s12),
//               ),
//             ),
//             SizedBox(height: Sizes.s16),
//             PoppinsText(
//               text: 'Switch Account',
//               fontSize: Sizes.s24,
//               fontWeight: FontWeight.w600,
//             ),
//             SizedBox(height: Sizes.s20),
//             Divider(height: Sizes.s1, color: ConstColors.greyE5E5),
//             SizedBox(height: Sizes.s20),
//             AgreementCheck(
//               title: "Asim_khan",
//               isChecked: selectValue,
//               onChanged: (value) {
//                 setState(() {
//                   selectValue = value!;
//                 });
//               },
//             ),

//             SizedBox(height: Sizes.s26),
//           ],
//         ),
//       ),
//     );
//   }
// }
