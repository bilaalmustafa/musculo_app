import 'package:flutter/material.dart';
import 'package:musculo_app/model/report_model.dart';
import '../../../../core/services/report_services.dart';

class ReportProvider with ChangeNotifier {
  final ReportService _reportService = ReportService();

  // List<ReportModel> _reportList = [];
  // List<ReportModel> get reportList => _reportList;

  bool _isLoading = false;
  String? _selectReason;

  bool get isLoading => _isLoading;
  String? get selectReason => _selectReason;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setSelectReason(String value) {
    _selectReason = value;
    notifyListeners();
  }

  void clearSelectReason() {
    _selectReason = null; // or however you store the selected reason
    notifyListeners();
  }

  /// Submit report (create document in Firebase)
  Future<void> submitReport({
    required String userId,
    String? contentId,
    required String contentType,
    String? userName,
    String? contentName,
    
     double? rating,
    String? reason,
    String? otherReason,
    String? email,
    String? note,
    String? image,
  }) async {
    try {
      setLoading(true);
      notifyListeners();

      final report = ReportModel(
        userId: userId,
        contentId: contentId,
        userName: userName,
        rating: rating,
        contentName: contentName,
        contentType: contentType,
      
        reason: _selectReason,
        otherReason: _selectReason == "Other" ? otherReason : null,
        email: email,
        note: note,
        image: image,
        timeStamp: DateTime.now(),
      );
      final reportId = DateTime.now().millisecondsSinceEpoch.toString();
      await _reportService.createReport(reportId, report);
    } catch (e) {
      debugPrint("Error submitting report: $e");
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  /// Optional: fetch all reports (for admin)
  // Future<void> fetchAllReports() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _reportList = await _reportService.getAll();
  //   } catch (e) {
  //     debugPrint("Error loading reports: $e");
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  /// Optional: fetch reports by contentId
  // Future<void> fetchReportsForContent(String contentId) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final allReports = await _reportService.getAll();
  //     _reportList = allReports.where((r) => r.contentId == contentId).toList();
  //   } catch (e) {
  //     debugPrint("Error filtering reports: $e");
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // void clearReports() {
  //   _reportList = [];
  //   notifyListeners();
  // }
}
