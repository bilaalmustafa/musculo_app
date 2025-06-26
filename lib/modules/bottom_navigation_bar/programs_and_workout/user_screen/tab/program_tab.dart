import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs_model.dart';

import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/program_item.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/program_filter.dart';
import '../../screen/view_model/discover_filter_provider.dart';

class ProgramTabDisScreen extends StatefulWidget {
  const ProgramTabDisScreen({super.key});

  @override
  State<ProgramTabDisScreen> createState() => _ProgramTabDisScreenState();
}

class _ProgramTabDisScreenState extends State<ProgramTabDisScreen> {
  Stream<List<ProgramModel>>? stream;

  @override
  void initState() {
    stream = instance<ProgramServices>().getPrograms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.secondary,
      body: Consumer<DiscoverFilter>(
        builder: (context, filter, child) {
          final query = filter.query;
          return StreamBuilder<List<ProgramModel>>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: PoppinsText(
                    text: "An error occurred: ${snapshot.error}",
                    fontSize: Sizes.s16,
                    color: ConstColors.black,
                  ),
                );
              }
              // if (!snapshot.hasData || snapshot.data == null) {
              //   return Center(
              //     child: PoppinsText(
              //       text: "No Programs Found",
              //       fontSize: Sizes.s16,
              //       color: ConstColors.black,
              //     ),
              //   );
              // }
              // if (snapshot.data!.isEmpty) {
              //   return Center(
              //     child: PoppinsText(
              //       text: "No Programs Found",
              //       fontSize: Sizes.s16,
              //       color: ConstColors.black,
              //     ),
              //   );
              // }

              // final data = snapshot.data ?? [];
              // final filtered =
              //     query.isEmpty
              //         ? data
              //         : data
              //             .where(
              //               (w) => w.programName!.toLowerCase().contains(
              //                 query.toLowerCase(),
              //               ),
              //             )
              //             .toList();
              print(
                '🔍 Applying filters with query: "$query" and isFilterApplied: ${filter.isFilterApplied}',
              );
              final data = snapshot.data ?? [];
              print('Total fetched: ${data.length}');
              final filtered =
                  (filter.isFilterApplied || query.isNotEmpty)
                      ? ProgramFilterUtil.applyFilters(data, filter, query)
                      : data;

              if (filtered.isEmpty) {
                return Center(
                  child: PoppinsText(
                    text: "No Programs",
                    fontSize: Sizes.s16,
                    color: ConstColors.black,
                  ),
                );
              }

              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return ProgramItemDis(program: filtered[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
