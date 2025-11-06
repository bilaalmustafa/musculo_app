import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/workouts_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/calender.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/history_list_tile.dart';

import '../../../../../core/services/exercise_services.dart';
import '../../../home_and_training_screens/screen/creator_mode/component/creatorworkoutlist.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key, required this.programModel});
  final ProgramModel programModel;

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  DateTime _focusedDay = DateTime.now();

  late WorkoutServices _workoutServices;
  List<String> selectedDaysOfWeek = [];

  @override
  void initState() {
    super.initState();
    _workoutServices = WorkoutServices();
    selectedDaysOfWeek = widget.programModel.dayAWeek ?? [];
    log(
      'Program ID: ${widget.programModel.programId}, Workout IDs: ${widget.programModel.listOfWorkoutIds}',
    );
  }

  List<DateTime> _getDatesFromDays(List<String> days) {
    final now = DateTime.now();
    // Monday = 1, Sunday = 7
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    final Map<String, int> dayMap = {
      'Mon': 1,
      'Tue': 2,
      'Wed': 3,
      'Thu': 4,
      'Fri': 5,
      'Sat': 6,
      'Sun': 7,
    };

    return days.map((day) {
      final weekday = dayMap[day];
      if (weekday == null) return now;
      return startOfWeek.add(Duration(days: weekday - 1));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.programModel;
    final workoutIds = data.listOfWorkoutIds ?? [];
    log('Fetching workouts for IDs: $workoutIds');

    final List<DateTime> highlightedDates = _getDatesFromDays(
      selectedDaysOfWeek,
    );

    return Scaffold(
      backgroundColor: ConstColors.white,
      body: FutureBuilder<List<WorkoutModel>>(
        future: Future.wait(
          workoutIds.map((id) => _workoutServices.getById(id)).toList(),
        ).then(
          (results) =>
              results.where((w) => w != null).cast<WorkoutModel>().toList(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: PoppinsText(
                text: 'Error loading workouts: ${snapshot.error}',
                fontSize: Sizes.s14,
                color: ConstColors.red,
              ),
            );
          }

          final workouts = snapshot.data ?? [];
          log('Fetched workouts count: ${workouts.length}');
          return SingleChildScrollView(
            child: Column(
              spacing: Sizes.s20,
              children: [
                CalenderWidget(
                  focusedDay: _focusedDay,
                  selectedDay: _focusedDay,
                  selectedDates: highlightedDates,
                  ondaySelected: (_, _) {},
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.s8),
                    border: Border.all(color: ConstColors.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.s10),
                    child: Column(
                      children: [
                        HistoryListTile(
                          headingtext: "Overall",
                          runtext: workoutIds.length.toString(),
                          timetext: data.totalTime.toString(),
                        ),
                        Divider(color: ConstColors.dividerColor),
                        HistoryListTile(
                          headingtext: (data.dayAWeek ?? []).join(","),
                          runtext: workoutIds.length.toString(),
                          timetext: data.totalTime.toString(),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child:
                      workouts.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(Sizes.s20),
                            child: Column(
                              children: [
                                SharePicture(imagePath: Assets.empty),
                                PoppinsText(
                                  text: "Empty",
                                  fontSize: Sizes.s16,
                                  fontWeight: TextWeight.semiBold,
                                ),
                                PoppinsText(
                                  text: "No workouts found for this program.",
                                  fontSize: Sizes.s12,
                                  color: ConstColors.greyA1A1,
                                ),
                              ],
                            ),
                          )
                          : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              final workout = workouts[index];

                              return CreatorWorkoutList(
                                workoutModel: workout,
                                showEditbutton: false,
                              );
                            },
                            separatorBuilder:
                                (_, index) => SizedBox(height: Sizes.s8),
                            itemCount: workouts.length,
                          ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
