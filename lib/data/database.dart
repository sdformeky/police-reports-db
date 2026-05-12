import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import 'repositories/ApplicantRepository.dart';
import 'repositories/DepartmentRepository.dart';
import 'repositories/PassportRepository.dart';
import 'repositories/EmployeeRepository.dart';
import 'repositories/IncriminatedArticleRepository.dart';
import 'repositories/ApplyingMethodRepository.dart';
import 'repositories/TimePlaceRepository.dart';
import 'repositories/PoliceReportRepository.dart';
import 'repositories/ReportInfoRepository.dart';

class PoliceDatabase {
  final Database sqlite;
  
  late final ApplicantRepository applicants;
  late final DepartmentRepository departments;
  late final PassportRepository passports;
  late final EmployeeRepository employees;
  late final IncriminatedArticleRepository articles;
  late final ApplyingMethodRepository applyingMethods;
  late final TimePlaceRepository timePlaces;
  late final PoliceReportRepository reports;
  late final ReportInfoRepository reportsInfo;

  PoliceDatabase._(this.sqlite) {
    sqlite.execute('PRAGMA foreign_keys = ON');
    
    applicants = ApplicantRepository(sqlite);
    departments = DepartmentRepository(sqlite);
    passports = PassportRepository(sqlite);
    employees = EmployeeRepository(sqlite);
    articles = IncriminatedArticleRepository(sqlite);
    applyingMethods = ApplyingMethodRepository(sqlite);
    timePlaces = TimePlaceRepository(sqlite);
    reports = PoliceReportRepository(sqlite);
    reportsInfo = ReportInfoRepository(sqlite);
  }

  static PoliceDatabase open({String dataDir = 'data'}) {
    Directory(dataDir).createSync(recursive: true);
    final filePath = p.join(dataDir, 'police_base.db');
    return PoliceDatabase._(sqlite3.open(filePath));
  }

  void createTables() {
    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS incriminated_articles (
        ID_incr_articles INTEGER PRIMARY KEY AUTOINCREMENT,
        incriminated_articles TEXT NOT NULL UNIQUE
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS applicants (
        ID_applicant INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT NOT NULL,
        middle_name TEXT,
        surname_name TEXT NOT NULL,
        phone_number TEXT NOT NULL UNIQUE,
        passport_ID TEXT NOT NULL UNIQUE
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS time_place (
        ID_time_place INTEGER PRIMARY KEY AUTOINCREMENT,
        violence_time TEXT NOT NULL,
        violence_date TEXT NOT NULL,
        violence_place TEXT NOT NULL
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS departments (
        ID_department INTEGER PRIMARY KEY AUTOINCREMENT,
        department TEXT NOT NULL
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS passports (
        ID_passport INTEGER PRIMARY KEY AUTOINCREMENT,
        serial TEXT NOT NULL,
        number TEXT NOT NULL,
        UNIQUE(serial, number)
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS employees (
        ID_employees INTEGER PRIMARY KEY AUTOINCREMENT,
        emp_surname TEXT NOT NULL,
        emp_name TEXT NOT NULL,
        emp_middle_name TEXT,
        department_ID INTEGER NOT NULL,
        passport_ID INTEGER NOT NULL UNIQUE,
        FOREIGN KEY(department_ID) REFERENCES departments(ID_department),
        FOREIGN KEY(passport_ID) REFERENCES passports(ID_passport)
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS applying_methods (
        ID_applying_methods INTEGER PRIMARY KEY AUTOINCREMENT,
        applying_method TEXT NOT NULL
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS police_reports (
        ID_report INTEGER PRIMARY KEY AUTOINCREMENT,
        applicant_ID INTEGER NOT NULL,
        time_place_ID INTEGER NOT NULL,
        requests INTEGER NOT NULL,
        familiarw_article INTEGER NOT NULL,
        report_date TEXT NOT NULL,
        report_time TEXT NOT NULL,
        applying_methods_ID INTEGER NOT NULL,
        employee_ID INTEGER NOT NULL,
        urgency INTEGER NOT NULL,
        FOREIGN KEY(applicant_ID) REFERENCES applicants(ID_applicant),
        FOREIGN KEY(employee_ID) REFERENCES employees(ID_employees),
        FOREIGN KEY(time_place_ID) REFERENCES time_place(ID_time_place),
        FOREIGN KEY(applying_methods_ID) REFERENCES applying_methods(ID_applying_methods)
      )
    ''');

    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS reports_info (
        ID_reports_info INTEGER PRIMARY KEY AUTOINCREMENT,
        incr_articles_ID INTEGER NOT NULL,
        report_ID INTEGER NOT NULL,
        FOREIGN KEY(report_ID) REFERENCES police_reports(ID_report) ON DELETE CASCADE,
        FOREIGN KEY(incr_articles_ID) REFERENCES incriminated_articles(ID_incr_articles)
      )
    ''');
  }

  void dispose() {
    sqlite.dispose();
  }
}