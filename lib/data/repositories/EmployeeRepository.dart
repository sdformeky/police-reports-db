import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/Employee.dart';

class EmployeeRepository {
  final Database db;

  EmployeeRepository(this.db);

  void insert(Employee employee) {
    final map = employee.toMap();
    db.execute('''
      INSERT OR REPLACE INTO employees (
        ID_employees, 
        emp_surname, 
        emp_name, 
        emp_middle_name, 
        department_ID, 
        passport_ID
      ) VALUES (?, ?, ?, ?, ?, ?)
    ''', [
      map["ID_employees"],
      map["emp_surname"],
      map["emp_name"],
      map["emp_middle_name"],
      map["department_ID"],
      map["passport_ID"],
    ]);
  }

  List<Employee> getAll() {
    final ResultSet results = db.select('SELECT * FROM employees');
    return results.map((row) => Employee.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM employees WHERE ID_employees = ?', [int.parse(id)]);
  }

  Employee? getEmployee(String id) {
    final result = db.select('SELECT * FROM employees WHERE ID_employees = ?', [int.parse(id)]);
    return result.isNotEmpty ? Employee.fromMap(result.first) : null;
  }
}