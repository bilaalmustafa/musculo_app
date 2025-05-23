// // 📁 models/feedback_model.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FeedbackModel {
//   final String id;
//   final String userId;
//   final String feedback;
//   final String? suggestion;
//   final String? email;
//   final DateTime createdAt;

//   FeedbackModel({
//     required this.id,
//     required this.userId,
//     required this.feedback,
//     this.suggestion,
//     this.email,
//     required this.createdAt,
//   });

//   factory FeedbackModel.fromJson(Map<String, dynamic> json) {
//     return FeedbackModel(
//       id: json['id'],
//       userId: json['user_id'],
//       feedback: json['feedback'],
//       suggestion: json['suggestion'],
//       email: json['email'],
//       createdAt: (json['created_at'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'feedback': feedback,
//       'suggestion': suggestion,
//       'email': email,
//       'created_at': Timestamp.fromDate(createdAt),
//     };
//   }
// }


// // 📁 services/firebase_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class FirebaseService<T> {
//   final String collectionName;
//   final T Function(Map<String, dynamic>) fromJson;
//   final Map<String, dynamic> Function(T) toJson;

//   FirebaseService({
//     required this.collectionName,
//     required this.fromJson,
//     required this.toJson,
//   });

//   Future<bool> create(String id, T item) async {
//     try {
//       await FirebaseFirestore.instance.collection(collectionName).doc(id).set(toJson(item));
//       return true;
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error storing data: $e");
//       return false;
//     }
//   }
// }


// // 📁 providers/feedback_provider.dart
// import 'package:flutter/material.dart';
// import '../models/feedback_model.dart';
// import '../services/firebase_service.dart';

// class FeedbackProvider with ChangeNotifier {
//   final FirebaseService<FeedbackModel> _feedbackService = FirebaseService<FeedbackModel>(
//     collectionName: "feedbacks",
//     fromJson: (json) => FeedbackModel.fromJson(json),
//     toJson: (item) => item.toJson(),
//   );

//   Future<void> submitFeedback({
//     required String userId,
//     required String feedback,
//     String? suggestion,
//     String? email,
//   }) async {
//     final model = FeedbackModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       userId: userId,
//       feedback: feedback,
//       suggestion: suggestion?.isNotEmpty == true ? suggestion : null,
//       email: email?.isNotEmpty == true ? email : null,
//       createdAt: DateTime.now(),
//     );

//     final success = await _feedbackService.create(model.id, model);
//     if (success) {
//       debugPrint("Feedback submitted successfully.");
//     }
//   }
// }


// // 📁 screens/feedback_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/feedback_provider.dart';
// import '../services/auth_service.dart';

// class FeedbackScreen extends StatefulWidget {
//   const FeedbackScreen({Key? key}) : super(key: key);

//   @override
//   State<FeedbackScreen> createState() => _FeedbackScreenState();
// }

// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final _feedbackController = TextEditingController();
//   final _suggestionController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Submit Feedback')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _feedbackController,
//               decoration: InputDecoration(labelText: 'Feedback'),
//             ),
//             TextField(
//               controller: _suggestionController,
//               decoration: InputDecoration(labelText: 'Suggestion (optional)'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email (optional)'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final provider = Provider.of<FeedbackProvider>(context, listen: false);
//                 provider.submitFeedback(
//                   userId: AuthService().currentUser?.uid ?? 'anonymous',
//                   feedback: _feedbackController.text.trim(),
//                   suggestion: _suggestionController.text.trim(),
//                   email: _emailController.text.trim(),
//                 );
//               },
//               child: Text('Submit'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


// // 📁 main.dart (Provider setup example)
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/feedback_provider.dart';
// import 'screens/feedback_screen.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => FeedbackProvider()),
//       ],
//       child: MaterialApp(
//         home: FeedbackScreen(),
//       ),
//     ),
//   );
// }
















// 📁 models/feedback_model.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// enum FeedbackCategory {
//   company,
//   training,
//   program,
//   creator,
// }

// class FeedbackModel {
//   final String id;
//   final String userId;
//   final FeedbackCategory category;
//   final String feedback;
//   final String? suggestion;
//   final String? email;
//   final DateTime createdAt;

//   FeedbackModel({
//     required this.id,
//     required this.userId,
//     required this.category,
//     required this.feedback,
//     this.suggestion,
//     this.email,
//     required this.createdAt,
//   });

//   factory FeedbackModel.fromJson(Map<String, dynamic> json) {
//     return FeedbackModel(
//       id: json['id'],
//       userId: json['user_id'],
//       category: FeedbackCategory.values.firstWhere((e) => e.toString() == 'FeedbackCategory.' + json['category']),
//       feedback: json['feedback'],
//       suggestion: json['suggestion'],
//       email: json['email'],
//       createdAt: (json['created_at'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'category': category.name,
//       'feedback': feedback,
//       'suggestion': suggestion,
//       'email': email,
//       'created_at': Timestamp.fromDate(createdAt),
//     };
//   }
// }


// // 📁 services/firebase_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class FirebaseService<T> {
//   final String collectionName;
//   final T Function(Map<String, dynamic>) fromJson;
//   final Map<String, dynamic> Function(T) toJson;

//   FirebaseService({
//     required this.collectionName,
//     required this.fromJson,
//     required this.toJson,
//   });

//   Future<bool> create(String id, T item) async {
//     try {
//       await FirebaseFirestore.instance.collection(collectionName).doc(id).set(toJson(item));
//       return true;
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error storing data: $e");
//       return false;
//     }
//   }
// }


// // 📁 providers/feedback_provider.dart
// import 'package:flutter/material.dart';
// import '../models/feedback_model.dart';
// import '../services/firebase_service.dart';

// class FeedbackProvider with ChangeNotifier {
//   final FirebaseService<FeedbackModel> _feedbackService = FirebaseService<FeedbackModel>(
//     collectionName: "feedbacks",
//     fromJson: (json) => FeedbackModel.fromJson(json),
//     toJson: (item) => item.toJson(),
//   );

//   Future<void> submitFeedback({
//     required String userId,
//     required FeedbackCategory category,
//     required String feedback,
//     String? suggestion,
//     String? email,
//   }) async {
//     final model = FeedbackModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       userId: userId,
//       category: category,
//       feedback: feedback,
//       suggestion: suggestion?.isNotEmpty == true ? suggestion : null,
//       email: email?.isNotEmpty == true ? email : null,
//       createdAt: DateTime.now(),
//     );

//     final success = await _feedbackService.create(model.id, model);
//     if (success) {
//       debugPrint("Feedback submitted successfully.");
//     }
//   }
// }


// // 📁 screens/feedback_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/feedback_provider.dart';
// import '../services/auth_service.dart';
// import '../models/feedback_model.dart';

// class FeedbackScreen extends StatefulWidget {
//   final FeedbackCategory category;
//   const FeedbackScreen({Key? key, required this.category}) : super(key: key);

//   @override
//   State<FeedbackScreen> createState() => _FeedbackScreenState();
// }

// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final _feedbackController = TextEditingController();
//   final _suggestionController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Submit ${widget.category.name} Feedback')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _feedbackController,
//               decoration: InputDecoration(labelText: 'Feedback'),
//             ),
//             TextField(
//               controller: _suggestionController,
//               decoration: InputDecoration(labelText: 'Suggestion (optional)'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email (optional)'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final provider = Provider.of<FeedbackProvider>(context, listen: false);
//                 provider.submitFeedback(
//                   userId: AuthService().currentUser?.uid ?? 'anonymous',
//                   category: widget.category,
//                   feedback: _feedbackController.text.trim(),
//                   suggestion: _suggestionController.text.trim(),
//                   email: _emailController.text.trim(),
//                 );
//               },
//               child: Text('Submit'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


// // 📁 main.dart (Provider setup example)
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/feedback_provider.dart';
// import 'screens/feedback_screen.dart';
// import 'models/feedback_model.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => FeedbackProvider()),
//       ],
//       child: MaterialApp(
//         home: CategorySelectionScreen(),
//       ),
//     ),
//   );
// }

// class CategorySelectionScreen extends StatelessWidget {
//   const CategorySelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Choose Feedback Type')),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text('Company Feedback'),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => FeedbackScreen(category: FeedbackCategory.company),
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Training Feedback'),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => FeedbackScreen(category: FeedbackCategory.training),
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Program Feedback'),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => FeedbackScreen(category: FeedbackCategory.program),
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Creator Feedback'),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => FeedbackScreen(category: FeedbackCategory.creator),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

