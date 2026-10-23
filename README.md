# Police Reports DB

A Dart console application that stores police reports in a SQLite database. The project is split into domain models and a data layer that uses the repository pattern.

**Stack:** Dart 3 · SQLite (`sqlite3` package) · `path`

## Database schema

Nine related tables, with foreign keys enabled through `PRAGMA foreign_keys = ON`:

| Table | Contents |
|---|---|
| `applicants` | People who filed a report: name, phone, passport |
| `passports` | Passport series and number (unique pair) |
| `departments` | Police departments |
| `employees` | Officers, each linked to a department and a passport |
| `applying_methods` | How the report was submitted |
| `time_place` | Time, date and place of the incident |
| `incriminated_articles` | Criminal code articles |
| `police_reports` | The report itself, linking an applicant, an employee, a time/place and a submission method; urgency flag |
| `reports_info` | Many-to-many link between reports and articles (`ON DELETE CASCADE`) |

```
applicants ──┐                ┌── employees ── departments
             ├── police_reports ┤              └─ passports
time_place ──┤        │        └── applying_methods
             │   reports_info ── incriminated_articles
```

## Project structure

```
lib/
├── domain/models/        # Plain Dart classes with toMap() / fromMap()
├── data/
│   ├── database.dart     # PoliceDatabase: opens the DB, creates the tables, exposes repositories
│   └── repositories/     # One repository per table: insert / getAll / getById / delete
└── export.dart
bin/main.dart             # Example: creates the tables, inserts an applicant, prints all applicants
```

## Running

```bash
dart pub get
dart run bin/main.dart
```

The database file is created at `data/police_base.db`.
