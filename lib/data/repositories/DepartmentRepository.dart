import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/Departments.dart';

class DepartmentRepository { 
  final Database db;

  DepartmentRepository(this.db);

  void insert(Department department) { 
    final map = department.toMap();
    db.execute('''
      INSERT OR REPLACE INTO departments (
        ID_department, department
      ) VALUES (?, ?)
    ''', [
      map['ID_department'], map['department']
    ]);
  }

  List<Department> getAll() {
    final ResultSet results = db.select('SELECT * FROM departments');
    return results.map((row) => Department.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM departments WHERE ID_department = ?', [int.parse(id)]);
  }

  Department? getDepartment(String id) {
    final result = db.select('SELECT * FROM departments WHERE ID_department = ?', [int.parse(id)]);
    return result.isNotEmpty ? Department.fromMap(result.first) : null;
  }
}