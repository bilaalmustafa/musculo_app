import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/share_picture.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/core/constants/assets.dart';
import 'package:musculo_app/model/motivational_text_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/profile_view_model/motivational_view_model.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/profile/user_profile_screens/motivational_text.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      Provider.of<MotivationalTextProvider>(
        context,
        listen: false,
      ).fetchMotivationalTextsByUserId(userId);
    });

    //    final userId = FirebaseAuth.instance.currentUser!.uid;
    // Provider.of<MotivationalTextProvider>(context, listen: false)
    //     .fetchMotivationalTextsByUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Motivational Text'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<MotivationalTextProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.motivationalTexts.isEmpty) {
              return const Center(child: Text("No motivational texts found."));
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => MotivationalTextScreen(
                                      editableText: text,
                                    ),
                              ),
                            );
                          },
                          child: SharePicture(
                            imagePath: Assets.editIcon1,
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            await _confirmAndDelete(context, provider, text);
                          },
                          child: SharePicture(
                            imagePath: Assets.deleteIcon,
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
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
        child: const Icon(Icons.add, color: ConstColors.white),
      ),
    );
  }
}

Future<void> _confirmAndDelete(
  BuildContext context,
  MotivationalTextProvider provider,
  MotivationalTextModel text,
) async {
  final bool? confirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete \n"${text.title}"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
              if (text.id == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid item: missing ID.')),
                );
                return;
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );

  if (confirm == true) {
    await provider.deleteMotivationalText(text.id!);
    Fluttertoast.showToast(msg: '"${text.title}" deleted');
  }
}
