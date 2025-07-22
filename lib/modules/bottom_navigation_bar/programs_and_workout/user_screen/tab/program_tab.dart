import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/core/services/creator_services.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/program_item_dis.dart';

import 'package:provider/provider.dart';

import '../../../../../components/custom_shimmer.dart';
import '../../../../../core/utils/program_filter.dart';
import '../../screen/view_model/discover_filter_provider.dart';

class ProgramTabDisScreen extends StatefulWidget {
  final String? userId;
  const ProgramTabDisScreen({super.key, this.userId});

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
                return Center(child: CustomShimmer(height: 50));
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

              print(
                '🔍 Applying filters with query: "$query" and isFilterApplied: ${filter.isFilterApplied}',
              );
              final data = snapshot.data ?? [];
              print('Total fetched: ${data.length}');

              // if user id not null then fetch that program
              final filteredByCreator =
                  widget.userId != null
                      ? data.where((p) => p.userId == widget.userId).toList()
                      : data;
              print('After creator filter: ${filteredByCreator.length}');

              // apply discover filter (search, plan type, price, etc) .
              final filtered =
                  (filter.isFilterApplied || query.isNotEmpty)
                      ? ProgramFilterUtil.applyFilters(data, filter, query)
                      : filteredByCreator;

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
