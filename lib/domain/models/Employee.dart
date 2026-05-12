import 'package:dart_application_1/domain/models/Identity.dart';

class Employee implements Identity {
  @override
  final String id;
  final String surname;
  final String firstName;
  final String? middleName;
  final String departmentId;
  final String passportId;

  Employee({
    required this.id,
    required this.surname,
    required this.firstName,
    this.middleName,
    required this.departmentId,
    required this.passportId,
  });

  Map<String, dynamic> toMap() => {
    "ID_employees": int.tryParse(id),
    "emp_surname": surname,
    "emp_name": firstName,
    "emp_middle_name": middleName,
    "department_ID": int.tryParse(departmentId),
    "passport_ID": int.tryParse(passportId),
  };

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map["ID_employees"].toString(),
      surname: map["emp_surname"] as String,
      firstName: map["emp_name"] as String,
      middleName: map["emp_middle_name"] as String?,
      departmentId: map["department_ID"].toString(),
      passportId: map["passport_ID"].toString(),
    );
  }
}