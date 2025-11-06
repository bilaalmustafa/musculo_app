// import 'package:flutter/material.dart';

// import 'package:musculo_app/core/constants/const_colors.dart';

// import 'package:musculo_app/modules/bottom_navigation_bar/component/home_app_bar.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/creator_mode.dart';
// import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/user_mode.dart';

// class HomeScreen extends StatefulWidget {
//   final int initialTabIndex;
//   const HomeScreen({super.key, this.initialTabIndex = 0});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late PageController _pageController;
//   bool isSwitch = false;

//   @override
//   void initState() {
//     super.initState();
//     //Initialize PageController with the provided initial tab index
//     _pageController = PageController(initialPage: widget.initialTabIndex);

//     // set the intial state of the switch
//     isSwitch = widget.initialTabIndex == 1;
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ConstColors.white,
//       appBar: HomeAppBar(
//         isSwitch: isSwitch,
//         valueChange:
//             (value) => setState(() {
//               isSwitch = value;
//               _pageController.jumpToPage(value ? 1 : 0);
//             }),
//       ),
//       body: PageView(
//         physics: NeverScrollableScrollPhysics(),
//         controller: _pageController,
//         children: [UserModeTab(), CreatorModeTab()],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:musculo_app/components/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/services/auth_services.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/component/home_app_bar.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/creator_mode/creator_mode.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/screen/user_mode/user_mode.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/home_and_training_screens/view_model/user_view_model.dart';
import 'package:musculo_app/core/config/injections.dart';

import '../../../../auth/view_model/view_mode_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  final AuthService _authService = instance<AuthService>();
    bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModeVm = context.watch<ViewModeProvider>();
    return StreamBuilder<UserModel?>(
      stream: context.read<UserViewModel>().getUserByIdstream(
        _authService.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CustomShimmer(height: 300)),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('An error occurred')));
        }

        final user = snapshot.data;
         if (user == null) {
          return const Scaffold(
            body: Center(child: Text('User not found')),
          );
        }

         if (!_isInitialized) {
          _isInitialized = true;
          if (user.userId != null) {
            viewModeVm.loadViewMode(user.userId!);
          }
        }

        final isCreator = (user.role ?? 'user') == 'creator';
        final isCreatorView = viewModeVm.isCreatorView;
        if (!isCreator && isCreatorView) {
  viewModeVm.setView(false);
}


        // Ensure correct page shows when role changes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pageController.jumpToPage(isCreatorView ? 1 : 0);
        });

        return Scaffold(
          backgroundColor: ConstColors.white,
          appBar: HomeAppBar(),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: const [UserModeTab(), CreatorModeTab()],
          ),
        );
      },
    );
  }
}
