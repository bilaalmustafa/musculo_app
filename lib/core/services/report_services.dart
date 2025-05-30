import 'package:musculo_app/core/services/firebase_service.dart';
import 'package:musculo_app/model/report_model.dart';

class ReportService extends FirebaseService<ReportModel> {
  ReportService()
    : super(
        collectionName:
            "reports", // or "report" depending on your Firestore naming
        fromJson: ReportModel.fromJson,
        toJson: (report) => report.toJson(),
      );

  Future<void> createReport(String id, ReportModel report) {
    return create(id, report);
  }

  // Optionally expose other CRUD operations as needed:

  // Future<ReportModel?> getReportById(String id) {
  //   return getById(id);
  // }

  // Future<List<ReportModel>> getAllReports() {
  //   return getAll();
  // }

  // Future<void> updateReport(String id, ReportModel report) {
  //   return update(id, report);
  // }

  // Future<void> deleteReport(String id) {
  //   return delete(id);
  // }
}
