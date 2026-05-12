import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/ApplyingMethod.dart';

class ApplyingMethodRepository {
  final Database db;

  ApplyingMethodRepository(this.db);

  void insert(ApplyingMethod method) {
    final map = method.toMap();
    db.execute('''
      INSERT OR REPLACE INTO applying_methods (
        ID_applying_methods, 
        applying_method
      ) VALUES (?, ?)
    ''', [
      map["ID_applying_methods"],
      map["applying_method"],
    ]);
  }

  List<ApplyingMethod> getAll() {
    final ResultSet results = db.select('SELECT * FROM applying_methods');
    return results.map((row) => ApplyingMethod.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM applying_methods WHERE ID_applying_methods = ?', [int.parse(id)]);
  }

  ApplyingMethod? getById(String id) {
    final result = db.select('SELECT * FROM applying_methods WHERE ID_applying_methods = ?', [int.parse(id)]);
    return result.isNotEmpty ? ApplyingMethod.fromMap(result.first) : null;
  }
}