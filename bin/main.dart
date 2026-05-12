import 'package:dart_application_1/export.dart';

void main() {
  final db = PoliceDatabase.open();
  db.createTables();
  Applicant ap = new Applicant(firstName: '1', surname: 'daun', middleName: 'daun', id: '1', phoneNumber: '123123', passportId: '1');
  db.insert(ap);
  db.dispose();
}