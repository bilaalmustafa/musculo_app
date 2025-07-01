import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/fonts.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/Program_Item_Dis.dart';
import 'package:provider/provider.dart';

import '../../../../../components/customTextField.dart';
import '../../../../../components/poppins_text.dart';
import '../../../../../core/config/injections.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/services/creator_services.dart';
import '../../../../../core/utils/program_filter.dart';
import '../../../../../model/programs_model.dart';
import '../../../programs_and_workout/screen/view_model/discover_filter_provider.dart';

class ProgramSearchScreen extends StatefulWidget {
  final TextEditingController controller;
  const ProgramSearchScreen({super.key, required this.controller});

  @override
  State<ProgramSearchScreen> createState() => _ProgramSearchScreenState();
}

class _ProgramSearchScreenState extends State<ProgramSearchScreen> {
  final FocusNode _focusNode = FocusNode();
  Stream<List<ProgramModel>>? stream;

  @override
  void initState() {
    super.initState();
    stream = instance<ProgramServices>().getPrograms();

    // Focus the text field after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, // Allow popping by default
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // This block runs only if the screen was actually popped

          widget.controller.clear();
          Provider.of<DiscoverFilter>(context, listen: false).clear();
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: ConstColors.white,

        body: SafeArea(
          child: Consumer<DiscoverFilter>(
            builder: (context, filter, _) {
              final query = filter.query.trim();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Sizes.s40,
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Navigator.pop(context);
                            },
                            child: SharePicture(imagePath: Assets.arrowleft),
                          ),
                        ),

                        Expanded(
                          child: CustomTextField(
                            controller: widget.controller,
                            title: "Search program",
                            focusNode: _focusNode,
                            preIcon: Assets.searchIcon,
                            sufIcon:
                                filter.isFilterApplied
                                    ? Assets.crossIcon
                                    : Assets.filterIcon,
                            onTap: () {
                              if (filter.isFilterApplied) {
                                filter.clear();
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  Routes.filterscreen,
                                );
                              }
                            },
                            onChanged: (val) => filter.setQuery(val),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Sizes.s10),

                  StreamBuilder<List<ProgramModel>>(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CustomShimmer(height: 100));
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

                      final data = snapshot.data ?? [];
                      data.sort(
                        (a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0),
                      );
                      final isFilter =
                          filter.isFilterApplied || query.isNotEmpty;
                      final filtered =
                          isFilter
                              ? ProgramFilterUtil.applyFilters(
                                data,
                                filter,
                                query,
                              )
                              : data;

                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.s20,
                                vertical: Sizes.s10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PoppinsText(
                                    text:
                                        query.isNotEmpty
                                            ? 'Results for “$query”'
                                            : 'Most Popular Programs',
                                    fontSize: Sizes.s16,
                                    fontWeight: TextWeight.semiBold,
                                  ),
                                  if (isFilter)
                                    PoppinsText(
                                      text: '${filtered.length} found',
                                      fontSize: Sizes.s14,
                                      fontWeight: TextWeight.semiBold,
                                    ),
                                ],
                              ),
                            ),
                            if (filtered.isEmpty)
                              Center(
                                child: PoppinsText(
                                  text: "No Programs Found",
                                  fontSize: Sizes.s16,
                                  color: ConstColors.black,
                                ),
                              )
                            else
                              Expanded(
                                child: ListView.builder(
                                  itemCount: filtered.length,
                                  itemBuilder: (context, index) {
                                    return ProgramItemDis(
                                      program: filtered[index],
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
