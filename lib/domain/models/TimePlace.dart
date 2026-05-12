import 'package:dart_application_1/domain/models/Identity.dart';

class TimePlace implements Identity {
  @override
  final String id;
  final String violenceTime;
  final DateTime violenceDate;
  final String violencePlace;

  TimePlace({
    required this.id,
    required this.violenceTime,
    required this.violenceDate,
    required this.violencePlace
  });

  Map<String, dynamic> toMap() => {
    "ID_time_place": int.tryParse(id),
    "violence_time": violenceTime,
    "violence_date": violenceDate.toIso8601String(),
    "violence_place": violencePlace,
  };

  factory TimePlace.fromMap(Map<String, dynamic> map) {
    return TimePlace(
      id: map["ID_time_place"].toString(),
      violenceTime: map["violence_time"] as String,
      violenceDate: DateTime.parse(map["violence_date"] as String),
      violencePlace: map["violence_place"] as String,
    );
  }
}