import 'package:dart_application_1/domain/models/Identity.dart';

class ReportInfo implements Identity {
  @override
  final String id;
  final String incrArticlesId;
  final String reportId;

  ReportInfo({
    required this.id,
    required this.incrArticlesId,
    required this.reportId,
  });

  Map<String, dynamic> toMap() => {
    "ID_reports_info": int.tryParse(id),
    "incr_articles_ID": int.tryParse(incrArticlesId),
    "report_ID": int.tryParse(reportId),
  };

  factory ReportInfo.fromMap(Map<String, dynamic> map) {
    return ReportInfo(
      id: map["ID_reports_info"].toString(),
      incrArticlesId: map["incr_articles_ID"].toString(),
      reportId: map["report_ID"].toString(),
    );
  }
}