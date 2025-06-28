import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:video_player/video_player.dart';

import '../../model/motivational_text_model.dart';

class FirebaseService<T> {
  final String collectionName;
  final T Function(Map<String, dynamic> data) fromJson;
  final Map<String, dynamic> Function(T item) toJson;

  FirebaseService({
    required this.collectionName,
    required this.fromJson,
    required this.toJson,
  });

  Future<bool> create(String id, T item) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .set(toJson(item));
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: "Unable to Store ${T.runtimeType}: $e");
      throw Exception('Error creating document: $e');
    }
  }

  Future<T?> update(String id, T item) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .update(toJson(item));

      return item;
    } catch (e) {
      Fluttertoast.showToast(msg: "Unable to Store ${T.runtimeType}: $e");
      throw Exception('Error : $e');
    }
  }

  Future<T?> getById(String id) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(id)
              .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return fromJson(data);
      }
      return null;
    } catch (e) {
      print(e);
      throw Exception('Error fetching document: $e');
    }
  }

  Stream<List<T>> getAllDiscovery(String type) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('type', isEqualTo: type)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => fromJson(doc.data())).toList();
        });
  }

  Stream<List<T>> getAllcreatorExercise(String type, String uid) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where("userId", isEqualTo: uid)
        .where('type', isEqualTo: type)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => fromJson(doc.data())).toList();
        });
  }

  Future<String?> uploadImage(File image, String uploadPath) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref('/images')
          .child(uploadPath);
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  //   Future<List<VideoModel>> fetchVideosWithDuration() async {
  //   final storageRef = FirebaseStorage.instance.ref().child('all_axe/');
  //   final listResult = await storageRef.listAll();

  //   List<VideoModel> videos = [];

  //   for (var item in listResult.items) {
  //     final downloadUrl = await item.getDownloadURL();
  //     final controller = VideoPlayerController.networkUrl( Uri.parse(downloadUrl));
  //     await controller.initialize();
  //     final duration = controller.value.duration;

  //     videos.add(VideoModel(
  //       name: item.name,
  //       url: downloadUrl,
  //       duration: duration,
  //     ));
  //   }

  //   return videos;
  // }
  // Add method to fetch all documents
  Future<List<T>> getAll() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection(collectionName)
              .orderBy('createdAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching all documents: $e');
      return [];
    }
  }

  // Add method to get random items
  Future<List<T>> getRandomItems({int limit = 3}) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      List<T> allItems =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return fromJson(data);
          }).toList();
      // Shuffle and take limited number
      allItems.shuffle();
      return allItems.take(limit).toList();
    } catch (e) {
      print('Error fetching random items: $e');
      return [];
    }
  }

  // New method to delete a document by ID
  Future<T?> delete(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .delete();
      Fluttertoast.showToast(msg: "Deleted successfully!");
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: "Unable to delete ${T.runtimeType}: $e");
      throw Exception('Error deleting document: $e');
    }
  }

  Future<List<MotivationalTextModel>> getMotivationalTextsByUserId(
    String userId,
  ) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('motivational_texts')
              .where('userId', isEqualTo: userId)
              .orderBy('createdAt', descending: true)
              .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MotivationalTextModel.fromJson(data, id: doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching motivational texts: $e');
      throw Exception('Failed to fetch motivational texts');
    }
  }
}
