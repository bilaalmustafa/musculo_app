import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileImageService {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickAndUploadImageAndUpdateProfile(ImageSource source) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not logged in';

      final pickedImage = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedImage == null) return;

      final file = File(pickedImage.path);

      // Upload image to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child(
        'profile_images/${user.uid}.jpg',
      );

      await ref.putFile(file);

      final downloadUrl = await ref.getDownloadURL();

      // Update Firestore with image URL
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'profileImageUrl': downloadUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error during profile update: $e');
    }
  }

  Stream<String?> userProfileImageStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.data()?['profileImageUrl'] as String?);
  }
}
