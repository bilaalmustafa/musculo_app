// import 'package:flutter/material.dart';
// import 'package:musculo_app/components/tab_buttons.dart';
// import 'package:musculo_app/core/config/extensions.dart';
// import 'package:musculo_app/core/constants/assets.dart';
// import 'package:musculo_app/core/constants/const_colors.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/show_rating_bottomsheet.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/tab/description_tab.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/tab/history_tab.dart';

// class ProgramDetailPageView extends StatefulWidget {
//   const ProgramDetailPageView({super.key});

//   @override
//   State<ProgramDetailPageView> createState() => _ProgramDetailPageViewState();
// }

// class _ProgramDetailPageViewState extends State<ProgramDetailPageView> {
//   late PageController _pageController;

//   int selecttab = 0;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ConstColors.white,
//       body: Column(
//         spacing: 10,
//         children: [
//           Stack(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: context.screenheight * 0.3,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(Assets.workout),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),

//               Positioned(
//                 top: context.screenheight * .07,
//                 left: 20,
//                 child: Icon(Icons.arrow_back_ios, color: ConstColors.white),
//               ),
//               Positioned(
//                 top: context.screenheight * 0.05,
//                 right: 10,
//                 child: PopupMenuButton<String>(
//                   color: ConstColors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   onSelected: (value) {
//                     if (value == "rate") {
//                       showModalBottomSheet(
//                         isScrollControlled: true,
//                         barrierColor: ConstColors.black.withValues(alpha: .8),
//                         constraints: BoxConstraints(
//                           maxHeight: context.screenheight * 0.7,
//                         ),
//                         backgroundColor: ConstColors.white,
//                         context: context,
//                         builder: (context) {
//                           return ShowrateBottomSheet();
//                         },
//                       );
//                     }
//                   },
//                   itemBuilder:
//                       (context) => [
//                         PopupMenuItem(
//                           value: 'rate',
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.star_border_outlined,
//                                 color: ConstColors.black,
//                               ),
//                               Text(' Rate program'),
//                             ],
//                           ),
//                         ),

//                         PopupMenuItem(
//                           value: 'cancel',
//                           child: Row(
//                             children: [
//                               Icon(Icons.cancel, color: ConstColors.red),
//                               Text(
//                                 ' Cancel program',
//                                 style: TextStyle(color: ConstColors.red),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                   icon: Icon(Icons.more_vert, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//           TabButtons(
//             tabNames: ["Description", "History"],
//             selecttab: selecttab,
//             onChange:
//                 (index) => setState(() {
//                   selecttab = index;
//                   _pageController.animateToPage(
//                     index,
//                     duration: Duration(milliseconds: 100),
//                     curve: Curves.easeInOut,
//                   );
//                 }),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: PageView(
//                 physics: NeverScrollableScrollPhysics(),
//                 controller: _pageController,
//                 children: [DescriptionTab(), HistoryTab()],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
