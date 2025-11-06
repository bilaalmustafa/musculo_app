import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/custom_button.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/extensions.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';

import 'package:musculo_app/model/sold_model.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/creator_list_tile.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/component/custom_chip.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/analysis_containers.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/paragraph_text.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_view_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/user_screen/component/show_rating_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_shimmer.dart';

import '../../../../core/services/user_service.dart';
import '../../feedback/screens/feedb_screen.dart';
import '../../feedback/screens/reportstab.dart';

class TraningPreviewScreen extends StatefulWidget {
  const TraningPreviewScreen({super.key, required this.workoutModel});

  final WorkoutModel workoutModel;
  @override
  State<TraningPreviewScreen> createState() => _TraningPreviewScreenState();
}

class _TraningPreviewScreenState extends State<TraningPreviewScreen> {
  bool isExpanded = false, isPurchased = false;
  late WorkoutModel _currentWorkoutModel;
  @override
  void initState() {
    _currentWorkoutModel = widget.workoutModel;
    final usermodel = context.read<UserViewModel>().userModel;
    Future.delayed(Duration.zero, () {
      final alreadyPurchased = usermodel!.listOfWorkouts.any(
        (w) => w.workoutId == widget.workoutModel.workoutId,
      );
      setState(() {
        isPurchased = alreadyPurchased;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = _currentWorkoutModel;
    Map<String, String> formatProgramTimeParts(int totalTimeInSeconds) {
      int totalMinutes = totalTimeInSeconds ~/ 60;

      if (totalMinutes < 60) {
        return {'digit': '$totalMinutes', 'unit': 'Minutes'};
      } else {
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;

        if (minutes >= 45) {
          hours += 1;
        }

        return {'digit': '$hours', 'unit': 'Hours'};
      }
    }

    final timeParts = formatProgramTimeParts(data.totalTime!);
    return Scaffold(
      backgroundColor: ConstColors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: context.screenheight * 0.3,
                decoration: BoxDecoration(
                  color: ConstColors.black,
                  boxShadow: [
                    BoxShadow(
                      color: ConstColors.grey888,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),

                // child: SharePicture(
                //   imagePath: Assets.bellyFat,
                //   fit: BoxFit.cover,
                // ),
                child: Center(
                  child: PoppinsText(
                    text: widget.workoutModel.creatorName![0].toUpperCase(),
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    color: ConstColors.white,
                  ),
                ),
              ),

              Positioned(
                top: context.screenheight * .07,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SharePicture(
                    imagePath: Assets.arrowleft,
                    colorFilter: ColorFilter.mode(
                      ConstColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: context.screenheight * 0.05,
                right: 10,
                child: PopupMenuButton<String>(
                  color: ConstColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (value) async {
                    if (value == 'Rate') {
                      final updatedWorkoutModel = await showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: ConstColors.black.withValues(alpha: .8),
                        constraints: BoxConstraints(
                          maxHeight: context.screenheight * 0.7,
                        ),
                        backgroundColor: ConstColors.white,
                        context: context,
                        builder: (context) {
                          return ShowrateSheet(
                            workoutModel: _currentWorkoutModel,
                          );
                        },
                      );
                      if (updatedWorkoutModel != null &&
                          updatedWorkoutModel is WorkoutModel) {
                        setState(() {
                          _currentWorkoutModel = updatedWorkoutModel;
                        });
                      }
                    }

                    if (value == "feedback") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => FeedBScreen(
                                feedbackType: 'Workout',
                                contentId: widget.workoutModel.workoutId,
                                rating: widget.workoutModel.rating,
                                contentName: widget.workoutModel.workoutName,
                              ),
                        ),
                      );
                    }
                    if (value == "report") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => Reportstab(
                                reportType: 'Report Workout',
                                contentId: widget.workoutModel.workoutId,
                                rating: widget.workoutModel.rating,
                                contentName: widget.workoutModel.workoutName,
                              ),
                        ),
                      );
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'Rate',
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_border_outlined,
                                color: ConstColors.black,
                              ),
                              SizedBox(width: Sizes.s8),
                              PoppinsText(
                                text: 'Rate Workout',
                                fontSize: Sizes.s14,
                                fontWeight: TextWeight.medium,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'feedback',
                          child: Row(
                            children: [
                              SharePicture(
                                imagePath: Assets.feedbackIcon,
                                colorFilter: ColorFilter.mode(
                                  ConstColors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text('Feedback'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'report',
                          child: Row(
                            children: [
                              SharePicture(
                                imagePath: Assets.reportIcon,
                                colorFilter: ColorFilter.mode(
                                  ConstColors.red,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Report',
                                style: TextStyle(color: ConstColors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                  icon: SharePicture(
                    imagePath: Assets.moreHrizontal,
                    colorFilter: ColorFilter.mode(
                      ConstColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  spacing: Sizes.s10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsText(
                      text: data.workoutName ?? "unknown",
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
                              "${data.rating ?? 0} (${data.ratingCount ?? 0} review)",
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
                          text: "For ${data.gender}",
                          color: ConstColors.secondary,
                        ),
                        CustomChip(
                          text: data.levelOf ?? "unknown",
                          color: ConstColors.secondary,
                        ),
                        CustomChip(
                          text: data.workoutType ?? "unknown",
                          color: ConstColors.secondary,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnalsisContainer(
                          iconImage: Assets.runnerIcon,
                          digit:
                              '${data.categorizedVideos?.values.fold(0, (sum, list) => sum + (list.length)) ?? 0}',
                          text: "Exercise",
                        ),
                        AnalsisContainer(
                          iconImage: Assets.chart,
                          digit: data.difficulty ?? "0",
                          text: "Difficulty",
                        ),
                        AnalsisContainer(
                          iconImage: Assets.timeCircle,
                          digit: timeParts["digit"].toString(),
                          text: timeParts["unit"].toString(),
                        ),
                      ],
                    ),
                    PoppinsText(
                      text: "Description",
                      fontSize: Sizes.s16,
                      fontWeight: TextWeight.semiBold,
                    ),

                    ParagraphText(
                      text: data.description.toString(),

                      isExpanded: isExpanded,

                      onTap:
                          () => setState(() {
                            isExpanded = !isExpanded;
                          }),
                    ),

                    PoppinsText(
                      text: "Creator",
                      fontSize: Sizes.s16,
                      fontWeight: TextWeight.semiBold,
                    ),
                    StreamBuilder<UserModel?>(
                      stream: UserService().userByIdstream(
                        widget.workoutModel.userId!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: CustomShimmer(height: 50),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PoppinsText(text: "Price", fontSize: 14),
                  PoppinsText(
                    text: "€ ${data.price!.toDouble().toStringAsFixed(2)}",
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
                  return CustomButton(
                    loading: vm.isloading,
                    onTap: () async {
                      final userModel = context.read<UserViewModel>().userModel;
                      if (userModel == null) return;
                      final creatorId = widget.workoutModel.userId!;
                      final creatorModel = await instance<UserService>()
                          .userById(creatorId);

                      if (isPurchased) {
                        // 🟥 CANCEL PURCHASE LOGIC
                        final confirm = await showDialog<bool>(
                          context: context,

                          builder:
                              (_) => AlertDialog(
                                title: const Text("Cancel Workout"),
                                content: const Text(
                                  "Are you sure you want to cancel this workout?",
                                ),
                                backgroundColor: Colors.white,
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, true),
                                    child: const Text("Yes"),
                                  ),
                                ],
                              ),
                        );

                        if (confirm != true) return;

                        // Remove from user's list
                        userModel.listOfWorkouts.removeWhere(
                          (w) => w.workoutId == data.workoutId,
                        );

                        // Remove from creator's sold list
                        if (creatorModel != null) {
                          creatorModel.sold.removeWhere(
                            (s) => s.contentId == data.workoutId,
                          );
                          await vm.addSoldInList(
                            creatorModel.userId!,
                            creatorModel,
                            creatorModel.sold,
                          );
                        }

                        // Update user Firestore
                        await vm.parchaseWorkout(
                          userModel.userId!,
                          userModel,
                          userModel.listOfWorkouts,
                        );

                        final functions = FirebaseFunctions.instance;
                        try {
                          await functions
                              .httpsCallable('sendCancelNotification')
                              .call({
                                'userId': userModel.userId,
                                'creatorId': creatorModel!.userId,
                                'type': 'workout',
                                'itemName': data.workoutName,
                              });
                          print("✅ Cancel notification sent to user & creator");
                        } catch (e) {
                          print("❌ Failed to send cancel notification: $e");
                        }

                        setState(() => isPurchased = false);
                        Fluttertoast.showToast(
                          msg: "Workout Purchase Cancelled",
                        );
                      } else {
                        // 🟢 BUY LOGIC (same as before)
                        final paymentSuccess = await vm.payPayment(
                          userModel.email ?? "",
                          data.price?.toDouble() ?? 0.0,
                        );

                        if (!paymentSuccess) {
                          Fluttertoast.showToast(msg: "Payment Failed");
                          return;
                        }

                        userModel.listOfWorkouts.add(data);

                        final purchaseResult = await vm.parchaseWorkout(
                          userModel.userId!,
                          userModel,
                          userModel.listOfWorkouts,
                        );

                        if (creatorModel != null) {
                          final updatedSoldList = List<SoldModel>.from(
                            creatorModel.sold,
                          );
                          updatedSoldList.add(
                            SoldModel(
                              type: "workout",
                              packegeMode: true,
                              userId: data.userId!,
                              contentName: data.workoutName ?? "unknown",
                              contentId: data.workoutId!,
                              contentPrice: data.price?.toDouble() ?? 0.0,
                              buyDate: DateTime.now(),
                            ),
                          );
                          await vm.addSoldInList(
                            creatorModel.userId!,
                            creatorModel,
                            updatedSoldList,
                          );
                        }

                        if (purchaseResult != null) {
                          setState(() => isPurchased = true);
                          Fluttertoast.showToast(
                            msg: "Workout Purchased Successfully",
                          );
                        }
                      }
                    },

                    // isPurchased
                    //     ? null
                    //     : () async {
                    //       final usermodel =
                    //           context.read<UserViewModel>().userModel;
                    //       if (usermodel == null) return;

                    //       final creatorId = widget.workoutModel.userId!;
                    //       final creatorModel = await instance<UserService>()
                    //           .userById(creatorId);

                    //       final paymentSuccess = await vm.payPayment(
                    //         usermodel.email ?? "",
                    //         data.price?.toDouble() ?? 0.0,
                    //       );

                    //       if (!paymentSuccess) {
                    //         Fluttertoast.showToast(msg: "Payment Failed");
                    //         return;
                    //       }

                    //       // 🟢 Payment succeeded — proceed
                    //       usermodel.listOfWorkouts.add(data);

                    //       final purchaseResult = await vm.parchaseWorkout(
                    //         usermodel.userId!,
                    //         usermodel,
                    //         usermodel.listOfWorkouts,
                    //       );

                    //       if (creatorModel != null) {
                    //         final updatedSoldList = List<SoldModel>.from(
                    //           creatorModel.sold,
                    //         );
                    //         updatedSoldList.add(
                    //           SoldModel(
                    //             type: "workout",
                    //             packegeMode: true,
                    //             userId: data.userId!,
                    //             contentName: data.workoutName ?? "unknown",
                    //             contentId: data.workoutId!,
                    //             contentPrice: data.price?.toDouble() ?? 0.0,
                    //             buyDate: DateTime.now(),
                    //           ),
                    //         );

                    //         await vm.addSoldInList(
                    //           creatorModel.userId!,
                    //           creatorModel,
                    //           updatedSoldList,
                    //         );
                    //       }

                    //       if (purchaseResult != null) {
                    //         setState(() {
                    //           isPurchased = usermodel.listOfWorkouts
                    //               .contains(data);
                    //         });

                    //         Fluttertoast.showToast(
                    //           msg: "Workout Purchased Successfully",
                    //         );
                    //       }
                    //     },
                    buttonText: isPurchased ? "Cancel Purchased" : "Buy",
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
