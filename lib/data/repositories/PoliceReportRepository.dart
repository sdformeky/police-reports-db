import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/PoliceReport.dart';

class PoliceReportRepository {
  final Database db;

  PoliceReportRepository(this.db);

  void insert(PoliceReport report) {
    final map = report.toMap();
    db.execute('''
      INSERT OR REPLACE INTO police_reports (
        ID_report, applicant_ID, time_place_ID, requests, 
        familiarw_article, report_date, report_time, 
        applying_methods_ID, employee_ID, urgency
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      map["ID_report"],
      map["applicant_ID"],
      map["time_place_ID"],
      map["requests"],
      map["familiarw_article"],
      map["report_date"],
      map["report_time"],
      map["applying_methods_ID"],
      map["employee_ID"],
      map["urgency"],
    ]);
  }

  List<PoliceReport> getAll() {
    final ResultSet results = db.select('SELECT * FROM police_reports');
    return results.map((row) => PoliceReport.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM police_reports WHERE ID_report = ?', [int.parse(id)]);
  }

  PoliceReport? getById(String id) {
    final result = db.select('SELECT * FROM police_reports WHERE ID_report = ?', [int.parse(id)]);
    return result.isNotEmpty ? PoliceReport.fromMap(result.first) : null;
  }
}