import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import '../component/transectionitem.dart';

class Paymenttab extends StatefulWidget {
  const Paymenttab({super.key});

  @override
  State<Paymenttab> createState() => _PaymenttabState();
}

class _PaymenttabState extends State<Paymenttab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.s10,
          children: [
            PoppinsText(
              text: 'Transaction History',
              fontSize: Sizes.s18,
              fontWeight: FontWeight.w600,
            ),

            Transectionitem(
              amount: 200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: -200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: 200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: 200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: -200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: 200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: 200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: -200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: -200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: -200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: 200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: -200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
            Transectionitem(
              amount: -200,
              date: 'Dec 14, 2024',
              time: '16:42 PM',
            ),
          ],
        ),
      ),
    );
  }
}
