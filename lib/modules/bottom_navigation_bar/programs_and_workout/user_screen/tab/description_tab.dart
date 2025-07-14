import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/payment_service.dart';
import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/sold_model.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/analysis_containers.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/injections.dart';
import '../../../../../model/user_model.dart';
import '../../component/paragraph_text.dart';

class DescriptionTab extends StatefulWidget {
  const DescriptionTab({super.key, required this.programModel});
  final ProgramModel programModel;

  @override
  State<DescriptionTab> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<DescriptionTab> {
  Future<UserModel?>? future;
  bool isExpanded = false, isPurchased = false;
  @override
  void initState() {
    future = instance<UserService>().userById(widget.programModel.userId!);
    final usermodel = context.read<UserViewModel>().userModel;
    Future.delayed(Duration.zero, () {
      final alreadyPurchased = usermodel!.listOfPrograms.any(
        (w) => w.programId == widget.programModel.programId,
      );
      setState(() {
        isPurchased = alreadyPurchased;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.programModel;
    String getWeeksFromDuration(int? durationInDays) {
      if (durationInDays == null || durationInDays <= 0) return "0";

      if (durationInDays < 7) return "1";

      final weeks = (durationInDays / 7).ceil();
      return weeks.toString();
    }

    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: Sizes.s10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(
                    text: data.programName ?? "unknown",
                    fontSize: Sizes.s20,
                    fontWeight: TextWeight.semiBold,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: ConstColors.orange,
                        size: Sizes.s20,
                      ),
                      PoppinsText(
                        text:
                            "${data.rating?.toStringAsFixed(1) ?? 0} (${data.review?.length ?? 0} review)",
                        fontSize: Sizes.s10,
                        fontWeight: TextWeight.regular,
                        color: ConstColors.greyA1A1,
                      ),
                    ],
                  ),
                  Row(
                    spacing: Sizes.s10,
                    children: [
                      CustomChip(
                        text: "For ${data.intended ?? "unknown"}",
                        color: ConstColors.secondary,
                      ),
                      CustomChip(
                        text: data.levelOf ?? "unknown",
                        color: ConstColors.secondary,
                      ),
                      CustomChip(
                        text: data.typeOf ?? "unknown",
                        color: ConstColors.secondary,
                      ),
                    ],
                  ),

                  PoppinsText(
                    text: "Description",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),
                  ParagraphText(
                    text:
                        "This is a long paragraph. It spans many lines. "
                        "We only want to show a few lines and then let the user tap View More. "
                        "This helps keep the UI clean and readable for longer content.This is a long paragraph. It spans many lines. "
                        "We only want to show a few lines and then let the user tap View More. "
                        "This helps keep the UI clean and readable for longer content.",

                    isExpanded: isExpanded,

                    onTap:
                        () => setState(() {
                          isExpanded = !isExpanded;
                        }),
                  ),

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "This is a long paragraph. It spans many lines. "
                  //       "We only want to show a few lines and then let the user tap View More. "
                  //       "This helps keep the UI clean and readable for longer content.This is a long paragraph. It spans many lines. "
                  //       "We only want to show a few lines and then let the user tap View More. "
                  //       "This helps keep the UI clean and readable for longer content.",
                  //       maxLines: isExpanded ? null : 5,
                  //       overflow: TextOverflow.fade,
                  //       style: TextStyle(fontSize: 13),
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         setState(() {
                  //           isExpanded = !isExpanded;
                  //         });
                  //       },
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(top: 4.0),
                  //         child: Text(
                  //           isExpanded ? "View Less" : "View More...",
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  PoppinsText(
                    text: "Creator",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),

                  FutureBuilder<UserModel?>(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError || !snapshot.hasData) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("Creator not found"),
                        );
                      }

                      return CreatorListTile(creator: snapshot.data!);
                    },
                  ),

                  PoppinsText(
                    text: "Workouts ",
                    fontSize: Sizes.s16,
                    fontWeight: TextWeight.semiBold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnalsisContainer(
                        iconImage: Assets.timeCircle,
                        digit: getWeeksFromDuration(data.duration),
                        text: "Weeks",
                      ),
                      AnalsisContainer(
                        iconImage: Assets.runnerIcon,
                        digit: data.listOfWorkouts?.length.toString() ?? "0",
                        text: "Workout",
                      ),
                      AnalsisContainer(
                        iconImage: Assets.chart,
                        digit: " ${data.timeAWeek}X",
                        text: "week",
                      ),
                    ],
                  ),
                  SizedBox(height: Sizes.s20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: 20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(text: "Price", fontSize: 13),
                  PoppinsText(
                    text:
                        "£${data.price?.toStringAsFixed(2).toString() ?? 0.0}",
                    fontSize: 16,
                    fontWeight: TextWeight.semiBold,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Consumer<DiscoverViewModel>(
                builder: (context, vm, _) {
                  UserModel? usermodel =
                      context.read<UserViewModel>().userModel;
                  final creatorId = widget.programModel.userId!;
                  return CustomButton(
                    loading: vm.isloading,
                    onTap:
                        usermodel!.listOfPrograms.contains(data)
                            ? null
                            : () async {
                              UserModel? creatorModel =
                                  await instance<UserService>().userById(
                                    creatorId,
                                  );

                              bool response = true;
                              // await PaymentService.initPaymentSheet(
                              //   email: usermodel?.email ?? "",
                              //   amount: data.price?.toDouble() ?? 0.0,
                              // );
                              if (response) {
                                usermodel.listOfPrograms.add(data);

                                UserModel? success = await vm.parchaseProgram(
                                  usermodel.userId!,
                                  usermodel,
                                  usermodel.listOfPrograms,
                                );
                                if (creatorModel != null) {
                                  // Ensure sold list is not null
                                  List<SoldModel> updatedSoldList = List.from(
                                    creatorModel.sold,
                                  );
                                  SoldModel soldItem = SoldModel(
                                    type: "program",
                                    packegeMode: true,
                                    userId: data.userId!,
                                    contentName: data.programName ?? "unknow",
                                    contentId: data.programId!,
                                    contentPrice: data.price?.toDouble() ?? 0.0,
                                    buyDate: DateTime.now(),
                                  );
                                  updatedSoldList.add(soldItem);

                                  // 3️⃣ Update Creator Document in Firestore
                                  await vm.addSoldInList(
                                    creatorModel.userId!,
                                    creatorModel,
                                    updatedSoldList,
                                  );
                                }
                                if (success != null) {
                                  setState(() {
                                    isPurchased = usermodel.listOfPrograms
                                        .contains(data);
                                    Fluttertoast.showToast(
                                      msg: "Program Purchased Successfully",
                                    );
                                  });
                                }
                              }
                            },
                    buttonText: isPurchased ? "Purchased" : "Buy",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
