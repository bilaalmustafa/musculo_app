import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musculo_app/model/workouts_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  bool get isUploading => _isUploading;

  Box<WorkoutModel>? _box;
  Box<ProgramModel>? _programBox;

  bool get boxesReady => _box != null && _programBox != null;

  List<WorkoutModel> get favorateWorkout => _box?.values.toList() ?? [];
  List<ProgramModel> get favoriteProgram => _programBox?.values.toList() ?? [];

  Future<void> initFavoritesForUser(String uid) async {
    final boxName = 'favorite_workouts_$uid';
    final programBoxName = 'favorite_programs_$uid';

    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<WorkoutModel>(boxName);
    } else {
      _box = Hive.box<WorkoutModel>(boxName);
    }

    if (!Hive.isBoxOpen(programBoxName)) {
      _programBox = await Hive.openBox<ProgramModel>(programBoxName);
    } else {
      _programBox = Hive.box<ProgramModel>(programBoxName);
    }
    notifyListeners();
  }

  void addFaverateWorkout(WorkoutModel model) {
    if (_box == null) return;
    final key = _box!.keys.firstWhere(
      (k) => _box!.get(k)?.workoutId == model.workoutId,
      orElse: () => null,
    );

    if (key != null) {
      _box!.delete(key);
    } else {
      _box!.add(model);
    }

    notifyListeners();
  }

  void addFaverateProgram(ProgramModel program) {
    if (_programBox == null) return;
    final key = _programBox!.keys.firstWhere(
      (p) => _programBox!.get(p)?.programId == program.programId,
      orElse: () => null,
    );

    if (key != null) {
      _programBox!.delete(key);
    } else {
      _programBox!.add(program);
    }

    notifyListeners();
  }

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
      }
    } catch (e) {
      print('Error loading profile image: $e');
    }
    notifyListeners();
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

        if (result != null) {
          _user = _user?.copyWith(profileImageUrl: result);
          _isUploading = false;
          notifyListeners();
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

  int _selectTab = 0;
  int get selectTab => _selectTab;

  void setTab(int val) {
    _selectTab = val;
    notifyListeners();
  }
}
