import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/ReportInfo.dart';

class ReportInfoRepository {
  final Database db;

  ReportInfoRepository(this.db);

  void insert(ReportInfo info) {
    final map = info.toMap();
    db.execute('''
      INSERT OR REPLACE INTO reports_info (
        ID_reports_info, 
        incr_articles_ID, 
        report_ID
      ) VALUES (?, ?, ?)
    ''', [
      map["ID_reports_info"],
      map["incr_articles_ID"],
      map["report_ID"],
    ]);
  }

  List<ReportInfo> getAll() {
    final ResultSet results = db.select('SELECT * FROM reports_info');
    return results.map((row) => ReportInfo.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM reports_info WHERE ID_reports_info = ?', [int.parse(id)]);
  }

  List<ReportInfo> getByReportId(String reportId) {
    final results = db.select('SELECT * FROM reports_info WHERE report_ID = ?', [int.parse(reportId)]);
    return results.map((row) => ReportInfo.fromMap(row)).toList();
  }
}