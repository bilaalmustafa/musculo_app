
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
}
