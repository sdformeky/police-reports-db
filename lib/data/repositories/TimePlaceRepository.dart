import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/TimePlace.dart';

class TimePlaceRepository {
  final Database db;

  TimePlaceRepository(this.db);

  void insert(TimePlace tp) {
    final map = tp.toMap();
    db.execute('''
      INSERT OR REPLACE INTO time_place (
        ID_time_place, 
        violence_time, 
        violence_date, 
        violence_place
      ) VALUES (?, ?, ?, ?)
    ''', [
      map["ID_time_place"],
      map["violence_time"],
      map["violence_date"],
      map["violence_place"],
    ]);
  }

  List<TimePlace> getAll() {
    final ResultSet results = db.select('SELECT * FROM time_place');
    return results.map((row) => TimePlace.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM time_place WHERE ID_time_place = ?', [int.parse(id)]);
  }

  TimePlace? getById(String id) {
    final result = db.select('SELECT * FROM time_place WHERE ID_time_place = ?', [int.parse(id)]);
    return result.isNotEmpty ? TimePlace.fromMap(result.first) : null;
  }
}