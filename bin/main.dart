import 'package:dart_application_1/export.dart';

void main() {
  final db = PoliceDatabase.open();
  db.createTables();
  Applicant ap = Applicant(firstName: 'Иван', surname: 'Петров', middleName: 'Сергеевич', id: '1', phoneNumber: '+79001234567', passportId: '1');
  db.applicants.insert(ap);
  for (Applicant a in db.applicants.getAll()) {
    print('${a.id}: ${a.surname} ${a.firstName} ${a.middleName ?? ''}, ${a.phoneNumber}');
  }
  db.dispose();
}
