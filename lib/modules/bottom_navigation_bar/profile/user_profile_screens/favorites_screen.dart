import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../components/profileappbar.dart';
import '../profile_view_model/profile_view_model.dart';
import 'programes.dart';
import 'workouts.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFavorites();
    });
  }

  Future<void> _initializeFavorites() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await profileProvider.initFavoritesForUser(user.uid);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favirate = context.watch<ProfileProvider>();
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: ProfileAppBar(
        appbarTitle: 'Favorites',
        selectedindex: _currentPage,
        onSelected: (value) {
          setState(() {
            _currentPage = value;
          });
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          WorkOuts(workoutModelList: favirate.favorateWorkout),
          Programs(
            tabselect: _currentPage,
            programModelList: favirate.favoritePrograms,
          ),
        ],

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstColors.black,
        shape: const CircleBorder(),

        onPressed: () {},
        child: Icon(Icons.add, color: ConstColors.white),
      ),
    );
  }
}
