import 'package:dart_application_1/domain/models/Identity.dart';

class Applicant implements Identity {
  @override
  final String id;
  final String firstName;
  final String? middleName;
  final String surname;
  final String phoneNumber;
  final String passportId;

  Applicant({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.surname,
    required this.phoneNumber,
    required this.passportId
  });

  Map<String, dynamic> toMap() => {
    "ID_applicant": int.tryParse(id), 
    "first_name": firstName,
    "middle_name": middleName,
    "surname_name": surname,
    "phone_number" : phoneNumber,
    "passport_ID" : int.tryParse(passportId)
  };

  factory Applicant.fromMap(Map<String, dynamic> map) {
    return Applicant(
      id: map["ID_applicant"].toString(),
      firstName: map["first_name"] as String,
      middleName: map["middle_name"] as String?,
      surname: map["surname_name"] as String,
      phoneNumber: map["phone_number"] as String,
      passportId: map["passport_ID"].toString()
    );
  }
}

