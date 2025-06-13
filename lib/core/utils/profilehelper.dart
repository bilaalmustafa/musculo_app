import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:provider/provider.dart';

import '../../modules/bottom_navigation_bar/profile/profile_view_model/profile_view_model.dart';

class ProfileHelper {
  static void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: ConstColors.greyC4C4,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Select Profile Picture',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageSourceOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    source: ImageSource.gallery,
                  ),
                  _buildImageSourceOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    source: ImageSource.camera,
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildImageSourceOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required ImageSource source,
  }) {
    return GestureDetector(
      onTap: () => _pickImage(context, source),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static Future<void> _pickImage(
    BuildContext context,
    ImageSource source,
  ) async {
    Navigator.pop(context); // Close bottom sheet

    final profileProvider = context.read<ProfileProvider>();
    await profileProvider.pickImage(source);
  }
}
