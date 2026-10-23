# Police Reports DB

A database of police reports, implemented twice:

- **Dart console app** (repository root): stores the data in SQLite, with domain models and a data layer built on the repository pattern.
- **Web app** ([`web/`](#web-version-nodejs--postgresql)): a REST API on Node.js, Express and PostgreSQL, plus an HTML/JS frontend.

**Stack:** Dart 3 · SQLite · Node.js · Express · PostgreSQL (`pg`) · vanilla JS

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

---

## Web version (Node.js + PostgreSQL)

```
web/
├── backend/
│   ├── server.js     # Express app: mounts the routes, serves the frontend at /frontend
│   ├── db.js         # PostgreSQL connection pool, settings from .env
│   └── routes/       # One router per table
└── frontend/         # A page and a script per table, using fetch() against the API
```

- **REST API:** list, add, update and delete endpoints for applicants, reports, employees, departments, passports, submission methods, articles, time/place records, report-article links and users.
- **Validation:** required fields are checked, and the API answers `400` when one is missing.
- **Queries:** all of them are parameterized (`$1, $2, …`), which protects against SQL injection.
- **Frontend:** plain HTML/CSS/JS pages with a table and an add/edit form for each entity.

### Running

```bash
cd web/backend
cp .env.example .env      # fill in your PostgreSQL connection details
npm install
node server.js            # http://localhost:3000/frontend/index.html
```

The PostgreSQL schema for this version extends the SQLite one: applicants get extra fields and there is a `users` table. The schema file is not included yet.
