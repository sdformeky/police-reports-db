import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/Passport.dart';

class PassportRepository {
  final Database db;

  PassportRepository(this.db);

  void insert(Passport passport) {
    final map = passport.toMap();
    db.execute('''
      INSERT OR REPLACE INTO passports (
        ID_passport, 
        serial, 
        number
      ) VALUES (?, ?, ?)
    ''', [
      map["ID_passport"],
      map["serial"],
      map["number"],
    ]);
  }

  List<Passport> getAll() {
    final ResultSet results = db.select('SELECT * FROM passports');
    return results.map((row) => Passport.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM passports WHERE ID_passport = ?', [int.parse(id)]);
  }

  Passport? getById(String id) {
    final result = db.select('SELECT * FROM passports WHERE ID_passport = ?', [int.parse(id)]);
    return result.isNotEmpty ? Passport.fromMap(result.first) : null;
  }
}