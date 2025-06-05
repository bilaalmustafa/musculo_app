import 'package:flutter/material.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/motivational_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/const_colors.dart';

class MotivationalListScreen extends StatefulWidget {
  const MotivationalListScreen({super.key});

  @override
  State<MotivationalListScreen> createState() => _MotivationalListScreenState();
}

class _MotivationalListScreenState extends State<MotivationalListScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch data once the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MotivationalTextProvider>(
        context,
        listen: false,
      ).fetchMotivationalTexts(); // You can also call fetchRandomMotivationalTexts()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Motivational Text'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<MotivationalTextProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.motivationalTexts.isEmpty) {
              return Center(child: Text("No motivational texts found."));
            }

            return ListView.builder(
              itemCount: provider.motivationalTexts.length,
              itemBuilder: (context, index) {
                final text = provider.motivationalTexts[index];
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: PoppinsText(
                      text: text.title ?? 'No title',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),

                    subtitle: PoppinsText(
                      text: text.description ?? 'No Message',
                      fontSize: 14,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // edit code here
                          },
                          child: SharePicture(
                            imagePath: Assets.editIcon1,
                            width: 18,
                            height: 18,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            // delete code here
                          },
                          child: SharePicture(
                            imagePath: Assets.deleteIcon,
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(
                              ConstColors.red,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstColors.black,
        shape: const CircleBorder(),

        onPressed: () {
          Navigator.pushNamed(context, Routes.motivationalScreen);
        },
        child: Icon(Icons.add, color: ConstColors.white),
      ),
    );
  }
}
