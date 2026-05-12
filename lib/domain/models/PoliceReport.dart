import 'package:dart_application_1/domain/models/Identity.dart';

class PoliceReport implements Identity {
  @override
  final String id;
  final String applicantId;
  final String timePlaceId;
  final bool requests;
  final bool familiarWithArticle;
  final DateTime reportDate;
  final String reportTime;
  final String applyingMethodsId;
  final String employeeId;
  final bool urgency;

  PoliceReport({
    required this.id,
    required this.applicantId,
    required this.timePlaceId,
    required this.requests,
    required this.familiarWithArticle,
    required this.reportDate,
    required this.reportTime,
    required this.applyingMethodsId,
    required this.employeeId,
    required this.urgency,
  });

  Map<String, dynamic> toMap() => {
    "ID_report": int.tryParse(id),
    "applicant_ID": int.tryParse(applicantId),
    "time_place_ID": int.tryParse(timePlaceId),
    "requests": requests ? 1 : 0,
    "familiarw_article": familiarWithArticle ? 1 : 0,
    "report_date": reportDate.toIso8601String(),
    "report_time": reportTime,
    "applying_methods_ID": int.tryParse(applyingMethodsId),
    "employee_ID": int.tryParse(employeeId),
    "urgency": urgency ? 1 : 0,
  };

  factory PoliceReport.fromMap(Map<String, dynamic> map) {
    return PoliceReport(
      id: map["ID_report"].toString(),
      applicantId: map["applicant_ID"].toString(),
      timePlaceId: map["time_place_ID"].toString(),
      requests: map["requests"] == 1,
      familiarWithArticle: map["familiarw_article"] == 1,
      reportDate: DateTime.parse(map["report_date"] as String),
      reportTime: map["report_time"] as String,
      applyingMethodsId: map["applying_methods_ID"].toString(),
      employeeId: map["employee_ID"].toString(),
      urgency: map["urgency"] == 1,
    );
  }
}