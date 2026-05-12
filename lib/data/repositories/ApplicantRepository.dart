import 'package:sqlite3/sqlite3.dart';
import 'package:dart_application_1/domain/models/Applicant.dart';

class ApplicantRepository {
  final Database db;

  ApplicantRepository(this.db);

  void insert(Applicant applicant) {
    final map = applicant.toMap();
    db.execute('''
      INSERT OR REPLACE INTO applicants (
        ID_applicant, first_name, middle_name, surname_name, phone_number, passport_ID
      ) VALUES (?, ?, ?, ?, ?, ?)
    ''', [
      map['ID_applicant'], 
      map['first_name'], 
      map['middle_name'], 
      map['surname_name'],
      map['phone_number'],
      map['passport_ID']
    ]);
  }

  List<Applicant> getAll() {
    final ResultSet results = db.select('SELECT * FROM applicants');
    return results.map((row) => Applicant.fromMap(row)).toList();
  }

  void delete(String id) {
    db.execute('DELETE FROM applicants WHERE ID_applicant = ?', [int.parse(id)]);
  }

  Applicant? getApplicant(String id) {
    final result = db.select('SELECT * FROM applicants WHERE ID_applicant = ?', [int.parse(id)]);
    return result.isNotEmpty ? Applicant.fromMap(result.first) : null;
  }
}