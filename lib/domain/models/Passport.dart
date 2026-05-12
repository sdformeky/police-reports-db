import 'package:dart_application_1/domain/models/Identity.dart';


class Passport implements Identity {
  @override
  final String id;
  final String serial;
  final String number;

  Passport({required this.id, required this.serial, required this.number});

  Map<String, dynamic> toMap() => {
    "ID_passport": int.tryParse(id),
    "serial": serial,
    "number": number,
  };

  factory Passport.fromMap(Map<String, dynamic> map) {
    return Passport(
      id: map["ID_passport"].toString(),
      serial: map["serial"] as String,
      number: map["number"] as String,
    );
  }
}