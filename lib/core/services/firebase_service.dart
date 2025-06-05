import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttertoast/fluttertoast.dart';

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

  Future<T?> updateUser(String id, T item) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .update(toJson(item));
      Fluttertoast.showToast(msg: "Updated successful");
      return item;
    } catch (e) {
      Fluttertoast.showToast(msg: "Unable to Store ${T.runtimeType}: $e");
      throw Exception('Error creating document: $e');
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
        return fromJson(doc.data() as Map<String, dynamic>);
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

  // Add method to fetch all documents
  Future<List<T>> getAll() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection(collectionName)
              .orderBy('createdAt', descending: true)
              .get();

      return snapshot.docs
          .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
          .toList();
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
          snapshot.docs
              .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
              .toList();

      // Shuffle and take limited number
      allItems.shuffle();
      return allItems.take(limit).toList();
    } catch (e) {
      print('Error fetching random items: $e');
      return [];
    }
  }
}
