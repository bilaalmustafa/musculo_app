// profile_provider.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
class ProfileProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  bool get isUploading => _isUploading;

  // Load existing profile image from Firestore
  Future<void> loadProfileImage() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .get();

        _user = UserModel.fromJson(doc.data()!, id: firebaseUser.uid);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading profile image: $e');
    }
  }

  // Pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        _isUploading = true;
        notifyListeners();

        final result = await _uploadImageToFirebase(File(image.path));
        _isUploading = false;
        if (result != null) {
          _user = _user?.copyWith(profileImageUrl: result);
        }
      }
    } catch (e) {
      _isUploading = false;
      notifyListeners();
    }
  }

  // Upload image to Firebase Storage and update Firestore
  Future<String?> _uploadImageToFirebase(File imageFile) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _isUploading = false;
        notifyListeners();
        return 'User not authenticated';
      }

      // Create a reference to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${user.uid}.jpg');

      // Upload the file

      final snapshot = await storageRef.putFile(imageFile);

      // Get the download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the new image URL
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'profileImageUrl': downloadUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return downloadUrl; // Success
    } catch (e) {
      _isUploading = false;
      notifyListeners();
      return 'Error uploading image: $e';
    }
  }
}
