import 'package:musculo_app/model/workouts_model.dart';

import '../../modules/bottom_navigation_bar/programs_and_workout/screen/view_model/discover_filter_provider.dart';

class WorkoutFilterUtil {
  // .........Filter function to apply all filters.......
  static List<WorkoutModel> applyFilters(
    List<WorkoutModel> workouts,
    DiscoverFilter filter,
    String query,
  ) {
    List<WorkoutModel> filtered = workouts;
    print('Before filtering: ${filtered.length}');

    // ..........Apply search query filter.........
    if (query.isNotEmpty) {
      filtered =
          filtered
              .where(
                (w) =>
                    (w.workoutName?.toLowerCase().contains(
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
      final planTypeOptions = ["All", "Without Equipment", "Stretching"];
      final selectedPlanType = planTypeOptions[filter.planType].toLowerCase();

      filtered =
          filtered.where((w) {
            final workoutType = w.workoutType?.toLowerCase() ?? '';
            switch (selectedPlanType) {
              case "without equipment":
                return workoutType.contains("without equipment");
              case "stretching":
                return workoutType.contains("stretching");
              default:
                return true;
            }
          }).toList();

      print("Workout types: ${workouts.map((w) => w.workoutType).toList()}");
      print('After plan type filter: ${filtered.length}');
    }

    // ............Apply Gender filter................
    if (filter.gender != 0) {
      // 0 = "All"
      final genderOptions = ["All", "Male", "Female"];
      final selectedGender = genderOptions[filter.gender];

      filtered =
          filtered.where((w) {
            return w.gender?.toLowerCase() == selectedGender.toLowerCase();
          }).toList();
      print('After gender filter: ${filtered.length}');
    }

    // ...........Apply Premium filter...........
    if (filter.premium) {
      filtered =
          filtered.where((w) {
            // Check if workout has a price > 0 (assuming premium workouts cost money)
            return (w.price ?? 0) > 0;
          }).toList();
      print('After premium filter: ${filtered.length}');
    }

    // ...........Apply Price filter.............
    filtered =
        filtered.where((w) {
          final price = (w.price ?? 0).toDouble();
          return price >= filter.price.start && price <= filter.price.end;
        }).toList();
    print('After price filter: ${filtered.length}');
    print('Workout Price: ${workouts.map((w) => w.price).toList()}');

    // ...........Apply Time Length filter..........
    filtered =
        filtered.where((w) {
          final duration = (w.totalTime ?? 0) / 60.toDouble();
          return duration >= filter.length.start &&
              duration <= filter.length.end;
        }).toList();
    print('After duration filter: ${filtered.length}');
    print('Workout durations: ${workouts.map((w) => w.totalTime).toList()}');

    // ...........Apply Difficulty filter..........
     {
      filtered =
          filtered.where((w) {
            // Convert difficulty string to numeric value for comparison
            double difficultyValue = _getDifficultyValue(w.difficulty);
            return difficultyValue <= filter.difficulty;
          }).toList();
      print('After difficulty filter: ${filtered.length}');
    }

    return filtered;
  }

  // ............Helper method to convert difficulty string to numeric value (0-10)..............
  static double _getDifficultyValue(String? difficulty) {
    if (difficulty == null) return 0;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return 4.0;
      case 'intermediate':
        return 7.0;
      case 'advanced':
        return 10.0;
      default:
        // Try to parse as number if it's already numeric
        return double.tryParse(difficulty) ?? 0;
    }
  }
}
