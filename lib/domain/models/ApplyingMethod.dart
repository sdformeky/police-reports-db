import 'package:dart_application_1/domain/models/Identity.dart';

class ApplyingMethod implements Identity {
  @override
  final String id;
  final String methodName;

  ApplyingMethod({required this.id, required this.methodName});

  Map<String, dynamic> toMap() => {
    "ID_applying_methods": int.tryParse(id),
    "applying_method": methodName,
  };

  factory ApplyingMethod.fromMap(Map<String, dynamic> map) {
    return ApplyingMethod(
      id: map["ID_applying_methods"].toString(),
      methodName: map["applying_method"] as String,
    );
  }
}