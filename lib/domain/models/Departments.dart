import 'package:dart_application_1/domain/models/Identity.dart';


class Department implements Identity {
  @override
  final String id;
  final String departmentName;

  Department({required this.id, required this.departmentName});

  Map<String, dynamic> toMap() => {
    "ID_department": int.tryParse(id), 
    "department": departmentName,
  };

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map["ID_department"].toString(),
      departmentName: map["department"] as String,
    );
  }
}