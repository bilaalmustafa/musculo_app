import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/sold_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../component/transectionitem.dart';

class Paymenttab extends StatefulWidget {
  const Paymenttab({super.key});

  @override
  State<Paymenttab> createState() => _PaymenttabState();
}

class _PaymenttabState extends State<Paymenttab> {
  @override
  Widget build(BuildContext context) {
    final userdata = context.read<UserViewModel>().userModel;

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
            userdata?.sold == null || userdata!.sold.isEmpty
                ? Center(
                  child: PoppinsText(
                    text: 'No Transaction History',
                    fontSize: Sizes.s14,

                    color: ConstColors.greyA1A1,
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: userdata.sold.length,
                  itemBuilder: (context, index) {
                    List<SoldModel> soldItems = userdata.sold;

                    return Transectionitem(
                      amount: soldItems[index].contentPrice,
                      date: soldItems[index].buyDate,
                      isGain: soldItems[index].packegeMode,
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
