import 'package:musculo_app/model/programs_model.dart';


import '../../modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_filter_provider.dart';

class ProgramFilterUtil {
  // .........Filter function to apply all filters.......
  static List<ProgramModel> applyFilters(
    List<ProgramModel> program,
    DiscoverFilter filter,
    String query,
  ) {
    List<ProgramModel> filtered = program;
    print('Before filtering: ${filtered.length}');

    // ..........Apply search query filter.........
    if (query.isNotEmpty) {
      filtered =
          filtered
              .where(
                (p) =>
                    (p.programName?.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ??
                        false),
              )
              .toList();
      print("Query received: $query");
      print('After query filter: ${filtered.length}');
    }

    // ...........Apply Plan Type filter...........
    if (filter.planType != 0) {
      final planTypeOptions = [
        "All",
        "Without Equipment",
        "Stretching",
      ];
      final selectedPlanType = planTypeOptions[filter.planType].toLowerCase();

      filtered =
          filtered.where((p) {
            final typeOf = p.typeOf?.toLowerCase() ?? '';
            switch (selectedPlanType) {
              case "without equipment":
                return typeOf.contains("without equipment");
              case "stretching":
                return typeOf.contains("stretching");
              default:
                return true;
            }
          }).toList();

      print("Workout types: ${program.map((p) => p.typeOf).toList()}");
      print('After plan type filter: ${filtered.length}');
    }

    // ............Apply Gender filter................
    if (filter.gender != 0) {
      // 0 = "All"
      final genderOptions = ["All", "Male", "Female"];
      final selectedGender = genderOptions[filter.gender];

      filtered =
          filtered.where((p) {
            return p.intended?.toLowerCase() == selectedGender.toLowerCase();
          }).toList();
      print('After gender filter: ${filtered.length}');
    }

    // ...........Apply Premium filter...........
    if (filter.premium) {
      filtered =
          filtered.where((p) {
            // Check if workout has a price > 0 (assuming premium workouts cost money)
            return (p.price ?? 0) > 0;
          }).toList();
      print('After premium filter: ${filtered.length}');
    }

    // ...........Apply Price filter.............
    filtered =
        filtered.where((p) {
          final price = (p.price ?? 0).toDouble();
          return price >= filter.price.start && price <= filter.price.end;
        }).toList();
    print('After price filter: ${filtered.length}');

    // ...........Apply Time Length filter..........
    filtered =
        filtered.where((p) {
          final duration = (p.totalTime ?? 0) / 60.toDouble();
          return duration >= filter.length.start &&
              duration <= filter.length.end;
        }).toList();
    print('After duration filter: ${filtered.length}');
    print('Workout durations: ${program.map((p) => p.totalTime).toList()}');

    // // ...........Apply Difficulty filter..........
    // if (filter.difficulty > 0) {
    //   filtered =
    //       filtered.where((w) {
    //         // Convert difficulty string to numeric value for comparison
    //         double difficultyValue = _getDifficultyValue(w.difficulty);
    //         return difficultyValue <= filter.difficulty;
    //       }).toList();
    //   print('After difficulty filter: ${filtered.length}');
    // }

    return filtered;
  }

  // // ............Helper method to convert difficulty string to numeric value (0-10)..............
  // static double _getDifficultyValue(String? difficulty) {
  //   if (difficulty == null) return 0;

  //   switch (difficulty.toLowerCase()) {
  //     case 'beginner':
  //     case 'easy':
  //       return 2.0;
  //     case 'intermediate':
  //     case 'medium':
  //       return 5.0;
  //     case 'advanced':
  //     case 'hard':
  //       return 8.0;
  //     case 'expert':
  //     case 'very hard':
  //       return 10.0;
  //     default:
  //       // Try to parse as number if it's already numeric
  //       return double.tryParse(difficulty) ?? 0;
  //   }
  // }
}
